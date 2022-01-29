--[[
    Portable Machines
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

local function node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_hard_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_hard_footstep", gain = 1.0}
	node_sound_defaults(table)
	return table
end

minetest.register_node("portable_machines:miner", {
    description = "Miner\n" .. 
      "Mines ore.\n" ..
      "Place on top of an ore node.\n" ..
      "Requires power.\n",
    tiles = {
        "machine.png", "miner_down.png",
        "miner.png", "miner.png",
        "miner.png", "miner.png"
    },
    groups = {dig_immediate=2},
    on_construct = function(pos)
      table.insert(power_consumers, pos)
      local meta = minetest.get_meta(pos)
      meta:set_string("formspec",
          "size[8,9]"..
          "label[3.6,0.75;Miner]" ..
          "list[current_name;main;3,2;8,4;]"..
          "list[current_player;main;0,5;8,4;]" ..
          "listring[]")
      meta:set_string("infotext", "Miner")
      local inv = meta:get_inventory()
      inv:set_size("main", 2*1)
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        for i,p in pairs(power_consumers) do
            if p.x == pos.x and p.y == pos.y and p.z == pos.z then
                table.remove(power_consumers, i)
                break
            end
        end
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    sounds = node_sound_metal_defaults(),
})

minetest.register_node("portable_machines:smelter", {
    description = "Smelter\n" ..
    "Slowly creates ingots from lumps.\n" ..
    "Requires fuel.",
    tiles = {
        "smelter.png", "smelter.png",
        "smelter.png", "smelter.png",
        "smelter.png", "smelter_front.png"
    },
    paramtype2="facedir",
    groups = {dig_immediate=2},
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
            "size[8,9]" ..
            "label[3.5,0.4;Smelter]" ..
            "list[current_name;main;3,1;8,4;]" ..
            "list[current_name;fuel;3,2.5;8,4;]" ..
            "label[3.65,3.5;Fuel]" ..
            "list[current_player;main;0,5;8,4;]" ..
            "listring[]")
        meta:set_string("infotext", "Smelter")
        local inv = meta:get_inventory()
        inv:set_size("main", 2*1)
        inv:set_size("fuel", 2*1)
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main") and inv:is_empty("fuel")
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    sounds = node_sound_stone_defaults(),
})

minetest.register_node("portable_machines:electric_smelter", {
    description = "Electric Smelter\n" ..
    "Creates ingots from lumps, 10 at a time.\n" ..
    "Requires power.",
    tiles = {
        "machine.png", "machine.png",
        "electric_smelter.png", "electric_smelter.png",
        "electric_smelter.png", "electric_smelter.png"
    },
    groups = {dig_immediate=2},
    on_construct = function(pos)
      table.insert(power_consumers, pos)
      local meta = minetest.get_meta(pos)
      meta:set_string("formspec",
          "size[8,9]" ..
          "label[3.1,0.75;Electric Smelter]" ..
          "list[current_name;main;3,2;8,4;]" ..
          "list[current_player;main;0,5;8,4;]" ..
          "listring[]")
      meta:set_string("infotext", "Electric Smelter")
      local inv = meta:get_inventory()
      inv:set_size("main", 2*1)
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        for i,p in pairs(power_consumers) do
            if p.x == pos.x and p.y == pos.y and p.z == pos.z then
                table.remove(power_consumers, i)
                break
            end
        end
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    sounds = node_sound_metal_defaults(),
})

minetest.register_node("portable_machines:extruder", {
    description = "Extruder\n" ..
    "Makes copper strips, steel bars and plastic strips.\n" ..
    "Provide with copper ingots, steel ingots or plastic sheets.\n" ..
    "Requires power.",
    tiles = {
        "machine.png", "machine.png",
        "extruder.png", "extruder.png",
        "extruder.png", "extruder.png"
    },
    groups = {dig_immediate=2},
    on_construct = function(pos)
      table.insert(power_consumers, pos)
      local meta = minetest.get_meta(pos)
      meta:set_string("formspec",
          "size[8,9]"..
          "label[3.46,0.75;Extruder]" ..
          "list[current_name;main;3,2;8,4;]" ..
          "list[current_player;main;0,5;8,4;]" ..
          "listring[]")
      meta:set_string("infotext", "Extruder")
      local inv = meta:get_inventory()
      inv:set_size("main", 2*1)
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        for i,p in pairs(power_consumers) do
            if p.x == pos.x and p.y == pos.y and p.z == pos.z then
                table.remove(power_consumers, i)
                break
            end
        end
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    sounds = node_sound_metal_defaults(),
})

minetest.register_node("portable_machines:stamper", {
    description = "Stamper\n" ..
    "Makes steel gears and plastic sheets.\n" ..
    "Provide with steel ingots or paraffin.\n" ..
    "Requires power.",
    tiles = {
        "machine.png", "machine.png",
        "stamper.png", "stamper.png",
        "stamper.png", "stamper.png"
    },
    groups = {dig_immediate=2},
    on_construct = function(pos)
        table.insert(power_consumers, pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
            "size[8,9]"..
            "label[3.5,0.75;Stamper]" ..
            "list[current_name;main;3,2;8,4;]" ..
            "list[current_player;main;0,5;8,4;]" ..
            "listring[]")
        meta:set_string("infotext", "Stamper")
        local inv = meta:get_inventory()
        inv:set_size("main", 2*1)
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        for i,p in pairs(power_consumers) do
            if p.x == pos.x and p.y == pos.y and p.z == pos.z then
                table.remove(power_consumers, i)
                break
            end
        end
    end,
    can_dig = function(pos,player)
        local meta = minetest.get_meta(pos);
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    sounds = node_sound_metal_defaults(),
})

minetest.register_node("portable_machines:autocrafter", {
    name = "autocrafter",
    description = "Autocrafter\n" .. 
        "Automatically crafts items.\n" ..
        "Requires power.",
    tiles = {"autocrafter.png"},
    groups = {dig_immediate=2},
    on_construct = function(pos)
    		local meta = minetest.get_meta(pos)
    		local inv = meta:get_inventory()
    		inv:set_size("src", 3*3)
    		inv:set_size("dst", 1*1)
    		inv:set_size("craft_item", 1)
    		local fs = 	"size[8,12]" ..
            "label[3.4,0;Autocrafter]" ..
            "label[2.1,1.25;Input]" .. 
            "label[0.9,2.75;(Autocrafter will craft this item.)]" ..
            "label[5.05,1.25;Output]" .. 
            "list[context;craft_item;2,1.75;1,1;]" ..
            "list[context;dst;5,1.75;1,1;]"..
            "label[3.5,4;Supplies]" ..
            "list[context;src;2.5,4.5;3,3;]" ..
            "list[current_player;main;0,8;8,4;]" ..
            "listring[current_player;main]"..
            "listring[context;src]" ..
            "listring[current_player;main]" ..
            "listring[context;dst]" ..
    			"listring[current_player;main]"
        meta:set_string("formspec",fs)
        table.insert(power_consumers, pos)
    end,
    can_dig = function(pos, player)
    		local meta = minetest.get_meta(pos)
    		local inv = meta:get_inventory()
    		return (inv:is_empty("src") and inv:is_empty("dst"))
    end,
    after_dig_node = function(pos)
        for i,p in pairs(power_consumers) do
            if p.x == pos.x and p.y == pos.y and p.z == pos.z then
                table.remove(power_consumers, i)
                break
            end
        end
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        return stack:get_count()
    end,
    sounds = node_sound_metal_defaults()
})
