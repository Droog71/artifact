--[[
    Portable Machines
    Author: Droog71
    License: AGPLv3
]]--

minetest.register_abm({
    nodenames = {"portable_machines:miner"},
    interval = 5,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local power = minetest.get_meta(pos):get_int("power")
        if is_consumer(pos) == false then
            table.insert(power_consumers, pos)
        elseif power_stable(pos) or power == 1 then
            minetest.get_meta(pos):set_int("power", 0)
            local under = vector.new(pos.x, pos.y - 1, pos.z)
            for node,ore in pairs(miner_recipes) do
                if minetest.get_node(under).name == node then
                    local meta = minetest.get_meta(pos)
                    local inv = meta:get_inventory()
                    local stack = ItemStack(ore)
                    inv:add_item("main", stack)
                    artifact_progress = artifact_progress + 1
                    minetest.sound_play("miner", {
                        pos = pos,
                        max_hear_distance = 8
                    })
                end
            end
        end
        local power_disp = (power_stable(pos) or power == 1) and "on" or "off"
        minetest.get_meta(pos):set_string("infotext", "Miner\n" .. "Power: " .. power_disp)
    end
})

minetest.register_abm({
    nodenames = {"portable_machines:smelter"},
    interval = 5,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local has_fuel = false
        local fuel = ""
        if inv:contains_item("fuel", "artifact:coal_lump") then
            fuel = "artifact:coal_lump"
            has_fuel = true
        elseif inv:contains_item("fuel", "artifact:stick") then
            fuel = "artifact:stick"
            has_fuel = true
        end  
        if has_fuel then
            local meta = minetest.get_meta({ x = pos.x, y = pos.y, z = pos.z })
            local inv = meta:get_inventory()
            local items = {}
            local working = false
            for input,output in pairs(smelter_recipes) do
                items[input] = ItemStack(input)
                items[input]:set_count(1)
            end
            for index, item in pairs(items) do
                if inv:contains_item("main", items[index]) then
                    local item_name = items[index]:get_name()
                    local product = smelter_recipes[item_name]
                    local stack = ItemStack(product)
                    stack:set_count(1)
                    if inv:add_item("main", stack) then
                        inv:remove_item("fuel", fuel)
                        inv:remove_item("main", items[index])
                        working = true
                    end
                end  
            end
            if working then
                artifact_progress = artifact_progress + 1
                minetest.sound_play("smelter", {
                    pos = pos,
                    max_hear_distance = 8
                })
            end
        end
    end
})

minetest.register_abm({
    nodenames = {"portable_machines:electric_smelter"},
    interval = 5,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local power = minetest.get_meta(pos):get_int("power")
        if is_consumer(pos) == false then
            table.insert(power_consumers, pos)
        elseif power_stable(pos) or power == 1 then
            minetest.get_meta(pos):set_int("power", 0)
            local meta = minetest.get_meta({ x = pos.x, y = pos.y, z = pos.z })
            local inv = meta:get_inventory()
            local items = {}
            local working = false
            for input,output in pairs(smelter_recipes) do
                items[input] = ItemStack(input)
                items[input]:set_count(10)
            end
            for index, item in pairs(items) do
                if inv:contains_item("main", items[index]) then
                    local item_name = items[index]:get_name()
                    local product = smelter_recipes[item_name]
                    local stack = ItemStack(product)
                    stack:set_count(10)
                    if inv:add_item("main", stack) then
                        inv:remove_item("main", items[index])
                        working = true
                    end
                end  
            end
            if working then
                artifact_progress = artifact_progress + 1
                minetest.sound_play("electric_smelter", {
                    pos = pos,
                    max_hear_distance = 8
                })
            end
        end
        local power_disp = (power_stable(pos) or power == 1) and "on" or "off"
        minetest.get_meta(pos):set_string("infotext", "Electric Smelter\n" .. "Power: " .. power_disp)
    end
})

minetest.register_abm({
    nodenames = {"portable_machines:autocrafter"},
    interval = 5,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local meta = minetest.get_meta(pos)
        local power = meta:get_int("power")
        if is_consumer(pos) == false then
            table.insert(power_consumers, pos)
        elseif power_stable(pos) or power == 1 then
            meta:set_int("power", 0)
            local inv = meta:get_inventory()
            local craft_item = inv:get_stack("craft_item", 1)
            local craft_name = craft_item:get_name()
            local recipe = minetest.get_craft_recipe(craft_name)
            local ready = true
            local items = {}
            if recipe.items then
                for index,item in pairs(recipe.items) do
                    if not inv:contains_item("src", item) then
                        ready = false
                        break
                    else
                        local stack = ItemStack(item)
                        stack:set_count(1)
                        table.insert(items, stack) 
                    end
                end
                if ready == true then
                    local used = {}
                    local amount = 0
                    local complete = true
                    for index,item in pairs(items) do
                        table.insert(used, item)
                        local removed = inv:remove_item("src", item)
                        if removed:get_name() == "" then
                            complete = false
                            break
                        end
                        amount = amount + 1
                    end
                    if complete == true and inv:add_item("dst", craft_item) then
                        minetest.sound_play("autocrafter", {
                            pos = pos,
                            max_hear_distance = 8
                        })
                    else
                        for index,item in pairs(used) do
                            inv:add_item("src", item)
                        end
                    end
                end
            end
        end
        local power_disp = (power_stable(pos) or power == 1) and "on" or "off"
        meta:set_string("infotext", "Autocrafter\n" .. "Power: " .. power_disp)
    end
})

minetest.register_abm({
    nodenames = {"portable_machines:extruder"},
    interval = 5,
    chance = 1,
    action = function(pos)
        update_machine("Extruder", pos, extruder_recipes, "extruder")
    end
})

minetest.register_abm({
    nodenames = {"portable_machines:stamper"},
    interval = 5,
    chance = 1,
    action = function(pos)
        update_machine("Stamper", pos, stamper_recipes, "stamper")
    end
})
