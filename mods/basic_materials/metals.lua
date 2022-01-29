-- Translation support
local S = minetest.get_translator("basic_materials")

minetest.register_craftitem("basic_materials:copper_wire", {
	description = S("Spool of Copper Wire"),
	groups = { wire = 1 },
	inventory_image = "basic_materials_copper_wire.png"
})

minetest.register_craftitem("basic_materials:gold_wire", {
	description = "Spool of Gold Wire",
	groups = { wire = 1 },
	inventory_image = "basic_materials_gold_wire.png"
})

minetest.register_craftitem("basic_materials:copper_strip", {
	description = S("Copper Strip\nCreated by extruder machine using copper ingots."),
	groups = { strip = 1 },
	inventory_image = "basic_materials_copper_strip.png"
})

minetest.register_craftitem("basic_materials:steel_bar", {
	description = S("Steel Bar\nCreated by extruder machine using steel ingots."),
	inventory_image = "basic_materials_steel_bar.png",
})

minetest.register_craftitem("basic_materials:gear_steel", {
	description = "Steel Gear",
	inventory_image = "basic_materials_gear_steel.png"
})

minetest.register_craftitem("basic_materials:empty_spool", {
	description = S("Empty Wire Spool"),
	inventory_image = "basic_materials_empty_spool.png"
})

-- crafts

minetest.register_craft( {
	output = "basic_materials:copper_wire 2",
	type = "shapeless",
	recipe = {
		"artifact:copper_ingot",
		"basic_materials:empty_spool",
		"basic_materials:empty_spool",
	},
})

minetest.register_craft( {
	output = "basic_materials:gold_wire 2",
	type = "shapeless",
	recipe = {
		"artifact:gold_ingot",
		"basic_materials:empty_spool",
		"basic_materials:empty_spool",
	},
})

minetest.register_craft( {
	output = "basic_materials:empty_spool 4",
	recipe = {
		{ "artifact:tin_ingot", "artifact:tin_ingot", "artifact:tin_ingot" },
		{ "", "artifact:tin_ingot", "" },
		{ "artifact:tin_ingot", "artifact:tin_ingot", "artifact:tin_ingot" }
	},
})

minetest.register_craft( {
	output = "basic_materials:gear_steel",
	recipe = {
		{ "", "artifact:steel_ingot", "" },
		{ "artifact:steel_ingot", "artifact:steel_plate", "artifact:steel_ingot" },
		{ "", "artifact:steel_ingot", "" }
	},
})
