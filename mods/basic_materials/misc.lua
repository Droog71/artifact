minetest.register_craftitem("basic_materials:oil_extract", {
    description = "Oil Extract",
    inventory_image = "basic_materials_oil_extract.png",
})

minetest.register_craftitem("basic_materials:paraffin", {
    description = "Paraffin\nCreated by smelting oil extract.\n" .. 
    "Used to create plastic sheets in stamper machine.\n" ..
    "Used to create plastic strips in extruder machine.",
    inventory_image = "basic_materials_paraffin.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "basic_materials:oil_extract",
	recipe = {
      "artifact:plant",
      "artifact:plant",
      "artifact:plant",
      "artifact:plant",
      "artifact:plant",
      "artifact:plant"
	}
})
