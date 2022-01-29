--[[
    Artifact
    Author: Droog71
    License: AGPLv3
]]--

minetest.register_item(":", { 
    type = "none", 
    wield_image = "hand.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            crumbly = {
                times={[1]=2.4, [2]=2, [3]=1.2},
                uses=0,
                maxlevel=1
            }
        }
    }
})

minetest.register_tool("artifact:pick_stone", {
    description = "Stone Pickaxe",
    inventory_image = "artifact_tool_stonepick.png",
    tool_capabilities = {
        full_punch_interval = 1.3,
        max_drop_level=0,
        groupcaps={
            cracky = {times={[2]=1.60, [3]=0.8}, uses=20, maxlevel=1},
            crumbly = {times={[1]=2, [2]=1.60, [3]=0.8}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=3},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {pickaxe = 1}
})

minetest.register_tool("artifact:pick_steel", {
    description = "Steel Pickaxe",
    inventory_image = "artifact_tool_steelpick.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=1,
        groupcaps={
            cracky = {times={[1]=4.00, [2]=1.20, [3]=0.60}, uses=50, maxlevel=2},
            crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1}
        },
        damage_groups = {fleshy=4},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {pickaxe = 1}
})

minetest.register_tool("artifact:shovel_stone", {
    description = "Stone Shovel",
    inventory_image = "artifact_tool_stoneshovel.png",
    wield_image = "artifact_tool_stoneshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.4,
        max_drop_level=0,
        groupcaps={
            crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
        },
        damage_groups = {fleshy=2},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {shovel = 1}
})

minetest.register_tool("artifact:shovel_steel", {
    description = "Steel Shovel",
    inventory_image = "artifact_tool_steelshovel.png",
    wield_image = "artifact_tool_steelshovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.1,
        max_drop_level=1,
        groupcaps={
            crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
        },
        damage_groups = {fleshy=3},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {shovel = 1}
})

local craft_ingreds = {
    stone = "group:stone",
    steel = "artifact:steel_ingot",
}

for name, mat in pairs(craft_ingreds) do
    minetest.register_craft({
        output = "artifact:pick_".. name,
        recipe = {
            {mat, mat, mat},
            {"", "group:stick", ""},
            {"", "group:stick", ""}
        }
    })

    minetest.register_craft({
        output = "artifact:shovel_".. name,
        recipe = {
            {mat},
            {"group:stick"},
            {"group:stick"}
        }
    })
end
