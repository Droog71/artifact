minetest.register_craftitem("basic_materials:silicon", {
	description = "Silicon lump",
	inventory_image = "basic_materials_silicon.png",
})

minetest.register_craftitem("basic_materials:ic", {
	description = "Simple Integrated Circuit",
	inventory_image = "basic_materials_ic.png",
})

minetest.register_craftitem("basic_materials:motor", {
	description = "Simple Motor",
	inventory_image = "basic_materials_motor.png",
})

minetest.register_craft( {
	output = "basic_materials:silicon",
	recipe = {
		{ "artifact:coal_lump", "basic_materials:paraffin" },
		{ "basic_materials:paraffin", "artifact:coal_lump" },
	},
})

minetest.register_craft( {
	output = "basic_materials:ic",
	recipe = {
        { "basic_materials:silicon", "basic_materials:copper_strip", "basic_materials:silicon" },
        { "basic_materials:plastic_strip", "artifact:gold_plate", "basic_materials:plastic_strip" },
        { "basic_materials:silicon", "basic_materials:copper_strip", "basic_materials:silicon" }
    }
})

minetest.register_craft( {
    output = "basic_materials:motor",
    recipe = {
        { "artifact:tin_ingot", "basic_materials:copper_wire", "artifact:tin_ingot" },
        { "artifact:tin_ingot", "", "artifact:tin_ingot" },
        { "artifact:tin_ingot", "basic_materials:copper_wire", "artifact:tin_ingot" }
    }
})
