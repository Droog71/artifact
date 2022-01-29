--[[
    Portable Machines
    Author: Droog71
    License: AGPLv3
]]--

dofile(minetest.get_modpath("portable_machines") .. DIR_DELIM .. "nodes.lua")
dofile(minetest.get_modpath("portable_machines") .. DIR_DELIM .. "crafting.lua")
dofile(minetest.get_modpath("portable_machines") .. DIR_DELIM .. "machine_recipes.lua")
dofile(minetest.get_modpath("portable_machines") .. DIR_DELIM .. "abm.lua")

function update_machine(name, pos, recipes, sound)
    local power = minetest.get_meta(pos):get_int("power")
    if is_consumer(pos) == false then
        table.insert(power_consumers, pos)
    elseif power_stable(pos) or power == 1 then
        minetest.get_meta(pos):set_int("power", 0)
        local meta = minetest.get_meta({ x = pos.x, y = pos.y, z = pos.z })
        local inv = meta:get_inventory()
        local items = {}
        local working = false
        for input,output in pairs(recipes) do
            items[input] = ItemStack(input)
            items[input]:set_count(1)
        end
        for index, item in pairs(items) do
            if inv:contains_item("main", items[index]) then
                local item_name = items[index]:get_name()
                local product = recipes[item_name]
                stack = ItemStack(product)
                stack:set_count(1)
                if inv:add_item("main", stack) then
                    inv:remove_item("main", items[index])
                    working = true
                end
            end  
        end
        if working then
            artifact_progress = artifact_progress + 1
            minetest.sound_play(sound, {
                pos = pos,
                max_hear_distance = 8
            })
        end
    end
    local power_disp = (power_stable(pos) or power == 1) and "on" or "off"
    minetest.get_meta(pos):set_string("infotext", name .. "\n" .. "Power: " .. power_disp)
end

