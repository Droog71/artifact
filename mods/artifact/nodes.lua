--[[
    Artifact
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

local function node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_hard_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_hard_footstep", gain = 1.0}
	node_sound_defaults(table)
	return table
end

local function node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_dirt_footstep", gain = 0.4}
	table.dug = table.dug or
			{name = "default_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	node_sound_defaults(table)
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

local function node_sound_wood_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_wood_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_wood_footstep", gain = 1.0}
	node_sound_defaults(table)
	return table
end

local function node_sound_leaves_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_grass_footstep", gain = 0.45}
	table.dug = table.dug or
			{name = "default_grass_footstep", gain = 0.7}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	node_sound_defaults(table)
	return table
end

minetest.register_node("artifact:rift", {
    name = "rift",
    description = "rift",
    tiles = {"rift.png"},
    drawtype = "mesh",
    mesh = "rift.obj",
    use_texture_alpha = "clip",
    groups = {not_in_creative_inventory = 1},
    paramtype2 = "facedir",
    walkable = false
})

minetest.register_node("artifact:torch", {
    name = "torch",
    description = "Torch",
    inventory_image = "artifact_torch.png",
    tiles = {"artifact_torch.png"},
    drawtype = "mesh",
    mesh = "torch.obj",
    use_texture_alpha = "clip",
    walkable = false,
    groups = {dig_immediate=2, falling_node = 1},
    sounds = node_sound_wood_defaults(),
    light_source = 14
})

minetest.register_node("artifact:grass", {
    name = "grass",
    description = "Grass",
    groups = {crumbly=3},
    sounds = node_sound_dirt_defaults(),
    tiles = {"artifact_grass.png"}
})

minetest.register_node("artifact:tree", {
    name = "tree",
    description = "Tree",
    tiles = {"artifact_tree.png"},
    drawtype = "mesh",
    mesh = "tree.obj",
    groups = {dig_immediate=2, not_in_creative_inventory = 1},
    sounds = node_sound_wood_defaults(),
    drop = "artifact:stick 10"
})

minetest.register_node("artifact:tree_2", {
    name = "tree_2",
    description = "Tree",
    tiles = {"artifact_tree_2.png"},
    drawtype = "mesh",
    mesh = "tree_2.obj",
    groups = {dig_immediate=2, not_in_creative_inventory = 1},
    sounds = node_sound_wood_defaults(),
    drop = "artifact:stick 10"
})

minetest.register_node("artifact:tree_3", {
    name = "tree_3",
    description = "Tree",
    tiles = {"artifact_tree.png"},
    drawtype = "mesh",
    mesh = "tree_3.obj",
    groups = {dig_immediate=2, not_in_creative_inventory = 1},
    sounds = node_sound_wood_defaults(),
    drop = "artifact:stick 10"
})

minetest.register_node("artifact:tree_4", {
    name = "tree_4",
    description = "Tree",
    tiles = {"artifact_tree_2.png"},
    drawtype = "mesh",
    mesh = "tree_4.obj",
    groups = {dig_immediate=2, not_in_creative_inventory = 1},
    sounds = node_sound_wood_defaults(),
    drop = "artifact:stick 10"
})

minetest.register_node("artifact:bedrock", {
    description = "Bedrock",
    groups = {not_in_creative_inventory = 1},
    tiles = {"artifact_bedrock.png"}
})

minetest.register_node("artifact:stone", {
    description = "Stone",
    tiles = {"artifact_stone.png"},
    groups = {cracky = 3, stone = 1},
    sounds = node_sound_stone_defaults(),
    drop = "artifact:stone",
})

minetest.register_node("artifact:rock", {
    description = "Rock",
    drawtype = 'mesh',
    mesh = "rock.obj",
    tiles = {"artifact_stone.png"},
    groups = {dig_immediate=2, stone=1, falling_node = 1},
    sounds = node_sound_stone_defaults()
})

minetest.register_node("artifact:stone_with_coal", {
    description = "Coal Ore",
    tiles = {"artifact_stone.png^artifact_mineral_coal.png"},
    groups = {cracky = 3},
    drop = "artifact:coal_lump",
    sounds = node_sound_stone_defaults()
})

minetest.register_node("artifact:stone_with_iron", {
    description = "Iron Ore",
    tiles = {"artifact_stone.png^artifact_mineral_iron.png"},
    groups = {cracky = 3},
    drop = "artifact:iron_lump",
    sounds = node_sound_stone_defaults()
})

minetest.register_node("artifact:stone_with_copper", {
    description = "Copper Ore",
    tiles = {"artifact_stone.png^artifact_mineral_copper.png"},
    groups = {cracky = 3},
    drop = "artifact:copper_lump",
    sounds = node_sound_stone_defaults()
})

minetest.register_node("artifact:stone_with_tin", {
    description = "Tin Ore",
    tiles = {"artifact_stone.png^artifact_mineral_tin.png"},
    groups = {cracky = 3},
    drop = "artifact:tin_lump",
    sounds = node_sound_stone_defaults()
})

minetest.register_node("artifact:stone_with_gold", {
    description = "Gold Ore",
    tiles = {"artifact_stone.png^artifact_mineral_gold.png"},
    groups = {cracky = 3},
    drop = "artifact:gold_lump",
    sounds = node_sound_stone_defaults()
})

minetest.register_node("artifact:plant", {
    description = "Plant",
    walkable = false,
    tiles = {"artifact_plant.png"},
    drawtype = "plantlike",
    inventory_image = "artifact_plant.png",
    on_use = function(itemstack, user, pointed_thing)
        return eat_food(itemstack, user, pointed_thing)
    end,
    groups = {crumbly = 3},
    sounds = node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = { -2/16, -7/16, -2/16, 2/16, 7/16, 2/16 }
    }
})