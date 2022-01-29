--[[
    Artifact
    Author: Droog71
    License: AGPLv3
]]--

dofile(minetest.get_modpath("artifact") .. DIR_DELIM .. "nodes.lua")
dofile(minetest.get_modpath("artifact") .. DIR_DELIM .. "items.lua")
dofile(minetest.get_modpath("artifact") .. DIR_DELIM .. "sprint.lua")
dofile(minetest.get_modpath("artifact") .. DIR_DELIM .. "tools.lua")
dofile(minetest.get_modpath("artifact") .. DIR_DELIM .. "hunger.lua")
dofile(minetest.get_modpath("artifact") .. DIR_DELIM .. "hud.lua")
dofile(minetest.get_modpath("artifact") .. DIR_DELIM .. "abm.lua")

local enable_fog = minetest.settings:get_bool("enable_fog")
local menu_clouds = minetest.settings:get_bool("menu_clouds")
local mip_map = minetest.settings:get_bool("mip_map")
local smooth_lighting = minetest.settings:get_bool("smooth_lighting")
local game_timer = 0
local game_loaded = false
rift_locations = {}
artifact_progress = 0

minetest.settings:set_bool("enable_fog", true)
minetest.settings:set_bool("menu_clouds", false)
minetest.settings:set_bool("mip_map", true)
minetest.settings:set_bool("smooth_lighting", true)

--loads data from file
local function load_game()
    local file = io.open(minetest.get_worldpath() .. DIR_DELIM .. "rifts.json", "r") 
    if file then
        local data = minetest.parse_json(file:read "*a")
        if data then
            if data.rift_locations then
                rift_locations = data.rift_locations
            end
        else
            minetest.log("error", "Failed to read rifts.json")
        end
        io.close(file)
    end
end

--saves data to file
local function save_rift_locations()
    local save_vars = {rift_locations = rift_locations}
    local save_data = minetest.write_json(save_vars)
    local save_path = minetest.get_worldpath() .. DIR_DELIM .. "rifts.json"
    minetest.safe_file_write(save_path, save_data)
end

--sets player variables and loads saved data
minetest.register_on_joinplayer(function(player)
    if player then
        player:hud_set_flags({
            hotbar = true,
            healthbar = false
        })
        skybox.set(player, 1)
        if game_loaded == false then
            load_game()
        end
    end
end)

--returns true if the node can be replaced with a rift
local function rift_node(name)
    return name == "air" or 
    name == "ignore" or
    name == "artifact:tree" or
    name == "artifact:tree_2" or
    name == "artifact:stone" or
    name == "artifact:grass" or
    name == "artifact:stone_with_coal" or
    name == "artifact:stone_with_tin" or
    name == "artifact:stone_with_copper" or
    name == "artifact:stone_with_iron" or
    name == "artifact:stone_with_gold"
end

--plays ambient sounds and spawns rifts
minetest.register_globalstep(function(dtime)
    game_timer = game_timer + 1
    if game_timer >= 1000 then
        local rand = math.random(1,4)
        local sound = "ambient_" .. rand
        minetest.sound_play(sound, {gain = 0.5})
        minetest.chat_send_all("progress: " .. artifact_progress)
        if artifact_progress >= 75 then
            for _,player in pairs(minetest.get_connected_players()) do
                local x_dif = math.random(10, 60)
                local z_dif = math.random(10, 60)
                x_dif = math.random(1, 100) >= 50 and (x_dif * -1) or x_dif
                z_dif = math.random(1, 100) >= 50 and (z_dif * -1) or z_dif
                local y = player:get_pos().y
                local x = player:get_pos().x + x_dif
                local z = player:get_pos().z + z_dif
                local spawn_pos = vector.new(x, y, z)
                local node_at_pos = minetest.get_node(spawn_pos).name
                if rift_node(node_at_pos) then
                    local rot = math.random(0,3)
                    local rotated_rift = {name = "artifact:rift", param2 = rot}
                    minetest.set_node(spawn_pos, rotated_rift)
                    table.insert(rift_locations, spawn_pos)
                end
            end
        end
        artifact_progress = 0
        game_timer = 0
        save_rift_locations()
    end
end)

--reverts settings to their original value
minetest.register_on_shutdown(function()
    minetest.settings:set_bool("enable_fog", enable_fog)
    minetest.settings:set_bool("menu_clouds", menu_clouds)
    minetest.settings:set_bool("mip_map", mip_map)
    minetest.settings:set_bool("smooth_lighting", smooth_lighting)
end)
