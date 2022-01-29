--[[
    Portable Power
    Author: Droog71
    License: AGPLv3
]]--

minetest.register_craft({
    type = "shaped",
    output = "portable_power:generator",
    recipe = {
        {"artifact:steel_ingot", "basic_materials:copper_wire", "artifact:steel_ingot"},
        {"basic_materials:copper_wire", "portable_machines:smelter", "basic_materials:copper_wire"},
        {"artifact:steel_ingot", "basic_materials:copper_wire", "artifact:steel_ingot"},
    }
})

minetest.register_craft({
    type = "shaped",
    output = "portable_power:solar_panel",
    recipe = {
        {"artifact:copper_plate", "artifact:copper_plate", "artifact:copper_plate"},
        {"basic_materials:silicon", "portable_power:generator", "basic_materials:silicon"},
        {"artifact:steel_plate", "basic_materials:copper_wire", "artifact:steel_plate"},
    }
})

minetest.register_craft({
    type = "shaped",
    output = "portable_power:power_transmitter",
    recipe = {
        {"basic_materials:plastic_sheet", "artifact:gold_plate", "basic_materials:plastic_sheet"},
        {"basic_materials:gold_wire", "basic_materials:ic", "basic_materials:gold_wire"},
        {"basic_materials:plastic_sheet", "artifact:gold_plate", "basic_materials:plastic_sheet"},
    }
})
