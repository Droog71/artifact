--[[
    Portable Machines
    Author: Droog71
    License: AGPLv3
]]--

miner_recipes = {
    ["artifact:stone_with_coal"] = "artifact:coal_lump",
    ["artifact:stone_with_tin"] = "artifact:tin_lump",
    ["artifact:stone_with_copper"] = "artifact:copper_lump",
    ["artifact:stone_with_iron"] = "artifact:iron_lump",
    ["artifact:stone_with_gold"] = "artifact:gold_lump"
}

smelter_recipes = {
    ["artifact:copper_lump"] = "artifact:copper_ingot",
    ["artifact:tin_lump"] = "artifact:tin_ingot",
    ["artifact:iron_lump"] = "artifact:steel_ingot",
    ["artifact:gold_lump"] = "artifact:gold_ingot",
    ["basic_materials:oil_extract"] = "basic_materials:paraffin"
}

extruder_recipes = {
    ["artifact:copper_ingot"] = "basic_materials:copper_strip",
    ["artifact:steel_ingot"] = "basic_materials:steel_bar",
    ["basic_materials:paraffin"] = "basic_materials:plastic_strip"
}

stamper_recipes = {
    ["basic_materials:paraffin"] = "basic_materials:plastic_sheet",
    ["artifact:tin_ingot"] = "artifact:tin_plate",
    ["artifact:copper_ingot"] = "artifact:copper_plate",
    ["artifact:steel_ingot"] = "artifact:steel_plate",
    ["artifact:gold_ingot"] = "artifact:gold_plate"
}
