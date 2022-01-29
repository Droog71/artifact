--[[
    Conveyors
    Author: Droog71
    License: AGPLv3
]]--

minetest.register_craft({
    type = "shaped",
    output = "conveyors:conveyor 3",
    recipe = {
        {"artifact:steel_plate", "artifact:steel_plate", "artifact:steel_plate"},
        {"basic_materials:steel_bar", "basic_materials:steel_bar", "basic_materials:steel_bar"},
        {"artifact:steel_plate", "artifact:steel_plate", "artifact:steel_plate"},
    }
})
