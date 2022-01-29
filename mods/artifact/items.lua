--[[
    Artifact
    Author: Droog71
    License: AGPLv3
]]--

minetest.register_craftitem("artifact:coal_lump", {
    description = "Coal Lump",
    inventory_image = "artifact_coal_lump.png"
})

minetest.register_craftitem("artifact:tin_ingot", {
    description = "Tin Ingot\nCreated by smelting tin lumps.",
    inventory_image = "artifact_tin_ingot.png"
})

minetest.register_craftitem("artifact:tin_lump", {
    description = "Tin Lump",
    inventory_image = "artifact_tin_lump.png"
})

minetest.register_craftitem("artifact:tin_plate", {
    description = "Tin Plate\nCreated by stamper machine using tin ingots.",
    inventory_image = "artifact_tin_plate.png"
})

minetest.register_craftitem("artifact:copper_ingot", {
    description = "Copper Ingot\nCreated by smelting copper lumps.",
    inventory_image = "artifact_copper_ingot.png"
})

minetest.register_craftitem("artifact:copper_lump", {
    description = "Copper Lump",
    inventory_image = "artifact_copper_lump.png"
})

minetest.register_craftitem("artifact:copper_plate", {
    description = "Copper Plate\nCreated by stamper machine using copper ingots.",
    inventory_image = "artifact_copper_plate.png"
})

minetest.register_craftitem("artifact:iron_lump", {
    description = "Iron Lump",
    inventory_image = "artifact_iron_lump.png"
})

minetest.register_craftitem("artifact:steel_ingot", {
    description = "Steel Ingot\nCreated by smelting steel lumps.",
    inventory_image = "artifact_steel_ingot.png"
})

minetest.register_craftitem("artifact:steel_plate", {
    description = "Steel Plate\nCreated by stamper machine using steel ingots.",
    inventory_image = "artifact_steel_plate.png"
})

minetest.register_craftitem("artifact:gold_ingot", {
    description = "Gold Ingot\nCreated by smelting gold lumps.",
    inventory_image = "artifact_gold_ingot.png"
})

minetest.register_craftitem("artifact:gold_lump", {
    description = "Gold Lump",
    inventory_image = "artifact_gold_lump.png"
})

minetest.register_craftitem("artifact:gold_plate", {
    description = "Gold Plate\nCreated by stamper machine using gold ingots.",
    inventory_image = "artifact_gold_plate.png"
})

minetest.register_craftitem("artifact:stick", {
    description = "Stick",
    inventory_image = "artifact_stick.png",
    groups = {stick = 1, },
})

minetest.register_craft({
    output = "artifact:torch 4",
    recipe = {
        {"artifact:coal_lump",},
        {"artifact:stick",},
    }
})