--[[
    Portable Machines
    Author: Droog71
    License: AGPLv3
]]--

minetest.register_craft({
    type = "shaped",
    output = "portable_machines:miner",
    recipe = {
        {"artifact:steel_plate", "artifact:steel_plate", "artifact:steel_plate"},
        {"artifact:steel_plate", "portable_power:generator", "artifact:steel_plate"},
        {"artifact:steel_plate", "artifact:pick_steel", "artifact:steel_plate"},
    }
})

minetest.register_craft({
    type = "shaped",
    output = "portable_machines:smelter",
    recipe = {
        {"artifact:stone", "artifact:stone", "artifact:stone"},
        {"artifact:stone", "", "artifact:stone"},
        {"artifact:stone", "artifact:stone", "artifact:stone"},
    }
})

minetest.register_craft({
    type = "shaped",
    output = "portable_machines:electric_smelter",
    recipe = {
        {"artifact:steel_plate", "artifact:steel_plate", "artifact:steel_plate"},
        {"artifact:steel_plate", "", "artifact:steel_plate"},
        {"artifact:steel_plate", "basic_materials:copper_wire", "artifact:steel_plate"},
    }
})

minetest.register_craft({
    type = "shaped",
    output = "portable_machines:extruder",
    recipe = {
        {"artifact:steel_plate", "basic_materials:motor", "artifact:steel_plate"},
        {"basic_materials:gear_steel", "", "basic_materials:gear_steel"},
        {"artifact:steel_plate", "basic_materials:motor", "artifact:steel_plate"},
    }
})

minetest.register_craft({
    type = "shaped",
    output = "portable_machines:stamper",
    recipe = {
        {"artifact:steel_ingot", "artifact:stone", "artifact:steel_ingot"},
        {"basic_materials:motor", "", "basic_materials:motor"},
        {"artifact:steel_ingot", "artifact:stone", "artifact:steel_ingot"},
    }
})

minetest.register_craft( {
    output = "portable_machines:autocrafter",
    recipe = {
        { "artifact:steel_plate", "basic_materials:motor", "artifact:steel_plate" },
        { "basic_materials:ic", "", "basic_materials:ic" },
        { "artifact:steel_plate", "basic_materials:motor", "artifact:steel_plate" }
    },
})
