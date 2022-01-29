minetest.register_craftitem("basic_materials:plastic_sheet", {
	description = "Plastic Sheet\nCreated by stamper machine using paraffin.",
	inventory_image = "basic_materials_plastic_sheet.png",
})

minetest.register_craftitem("basic_materials:plastic_strip", {
	description = "Plastic Strips\nCreated by extruder machine using paraffin.",
	groups = { strip = 1 },
	inventory_image = "basic_materials_plastic_strip.png",
})
