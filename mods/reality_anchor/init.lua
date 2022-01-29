--[[
    Hydroponics Bay
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

minetest.register_node("reality_anchor:reality_anchor", {
    description = "Reality Anchor\n" ..
    "Building large factories will eventually cause rifts to appear in the world.\n" ..
    "Rifts are hazardous. Reality anchors will destroy any rift within 20 meters.\n",
    tiles = {
        "reality_anchor_machine.png", "reality_anchor_machine.png",
        "reality_anchor.png", "reality_anchor.png",
        "reality_anchor.png", "reality_anchor.png"
    },
    groups = {dig_immediate=2},
    sounds = node_sound_metal_defaults(),
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Reality Anchor")
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        for i,p in pairs(power_consumers) do
            if p.x == pos.x and p.y == pos.y and p.z == pos.z then
                table.remove(power_consumers, i)
                break
            end
        end
    end
})

minetest.register_abm({
    nodenames = {"reality_anchor:reality_anchor"},
    interval = 5,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local power = minetest.get_meta(pos):get_int("power")
        if is_consumer(pos) == false then
            table.insert(power_consumers, pos)
        elseif power_stable(pos) or power == 1 then
            for index,loc in pairs(rift_locations) do
                if vector.distance(pos, loc) <= 20 then
                    minetest.remove_node(loc)
                    table.remove(rift_locations, index)
                    minetest.sound_play("reality_anchor", {
                        pos = pos,
                        max_hear_distance = 8
                    })
                end
            end
        end
        local power_disp = (power_stable(pos) or power == 1) and "on" or "off"
        minetest.get_meta(pos):set_string("infotext", "Reality Anchor\n" .. "Power: " .. power_disp)
    end
})

minetest.register_craft({
    type = "shaped",
    output = "reality_anchor:reality_anchor",
    recipe = {
        {"portable_power:power_transmitter", "portable_power:power_transmitter", "portable_power:power_transmitter"},
        {"basic_materials:gear_steel", "portable_machines:electric_smelter", "basic_materials:gear_steel"},
        {"basic_materials:motor", "portable_power:generator", "basic_materials:motor"},
    }
})
