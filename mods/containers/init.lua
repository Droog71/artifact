--[[
    Containers
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

minetest.register_node("containers:container", {
    name = "container",
    description = "Container",
    tiles = {"container.png"},
    groups = {dig_immediate=2},
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
            "size[8,9]" ..
            "list[current_name;main;0,0;8,4;]" ..
            "list[current_player;main;0,5;8,4;]" ..
            "listring[]")
        meta:set_string("infotext", "Container")
        local inv = meta:get_inventory()
        inv:set_size("main", 8*4)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    sounds = node_sound_metal_defaults()
})

minetest.register_craft({
    type = "shaped",
    output = "containers:container",
    recipe = {
        {"artifact:tin_plate", "artifact:tin_plate", "artifact:tin_plate"},
        {"artifact:tin_plate", "", "artifact:tin_plate"},
        {"artifact:tin_plate", "artifact:tin_plate", "artifact:tin_plate"},
    }
})
