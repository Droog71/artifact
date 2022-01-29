--[[
    Hydroponics
    Author: Droog71
    License: AGPLv3
]]--

local function node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "default_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "default_place_node_hard", gain = 1.0}
	return table
end

local function node_sound_metal_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_metal_footstep", gain = 0.4}
	table.dig = table.dig or
			{name = "default_dig_metal", gain = 0.5}
	table.dug = table.dug or
			{name = "default_dug_metal", gain = 0.5}
	table.place = table.place or
			{name = "default_place_node_metal", gain = 0.5}
	node_sound_defaults(table)
	return table
end

minetest.register_node("hydroponics:hydroponics_bay", {
    description = "Hydroponics Bay\n" .. 
    "Grows plants.\n" ..
    "Requires power.\n",
    tiles = {
        "hydroponics_machine.png", "hydroponics_machine.png",
        "hydroponics_bay.png", "hydroponics_bay.png",
        "hydroponics_bay.png", "hydroponics_bay.png"
    },
    groups = {dig_immediate=2},
    sounds = node_sound_metal_defaults(),
    on_construct = function(pos)
        table.insert(power_consumers, pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
            "size[8,9]"..
            "label[3.05,0.75;Hydroponics Bay]" ..
            "list[current_name;main;3,2;8,4;]"..
            "list[current_player;main;0,5;8,4;]" ..
            "listring[]")
        meta:set_string("infotext", "Hydroponics Bay")
        local inv = meta:get_inventory()
        inv:set_size("main", 2*1)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        for i,p in pairs(power_consumers) do
            if p.x == pos.x and p.y == pos.y and p.z == pos.z then
                table.remove(power_consumers, i)
                break
            end
        end
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
       return stack:get_count()
    end
})

minetest.register_abm({
    nodenames = {"hydroponics:hydroponics_bay"},
    interval = 5,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local power = minetest.get_meta(pos):get_int("power")
        if is_consumer(pos) == false then
            table.insert(power_consumers, pos)
        elseif power_stable(pos) or power == 1 then
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local stack = ItemStack("artifact:plant")
            inv:add_item("main", stack)
            artifact_progress = artifact_progress + 1
            minetest.sound_play("hydroponics_bay", {
                pos = pos,
                max_hear_distance = 8
            })
        end
        local power_disp = (power_stable(pos) or power == 1) and "on" or "off"
        minetest.get_meta(pos):set_string("infotext", "Hydroponics Bay\n" .. "Power: " .. power_disp)
    end
})

minetest.register_craft({
    type = "shaped",
    output = "hydroponics:hydroponics_bay",
    recipe = {
        {"artifact:tin_plate", "portable_machines:smelter", "artifact:tin_plate"},
        {"artifact:tin_plate", "", "artifact:tin_plate"},
        {"artifact:tin_plate", "artifact:grass", "artifact:tin_plate"},
    }
})
