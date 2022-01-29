--[[
    Artifact
    Author: Droog71
    License: AGPLv3
]]--

local hp_hud_ids = {}
local hp_hud_labels = {}
local hunger_hud_ids = {}
local hunger_label_ids = {}
local hud_timer = 0

--initializes all of the HUD elements
minetest.register_on_joinplayer(function(player)
    if player then
        player:hud_add({
            hud_elem_type = "image",
            position = {x = 0.1, y = 0.88},
            offset = {x = 0, y = 0},
            scale = {x = 1, y = 1},
            text = "hud_bar_bg.png",
            number = 0xFFFFFF
        })
        hunger_hud_ids[player:get_player_name()] = player:hud_add({
            hud_elem_type = "image",
            position = {x = 0.1, y = 0.88},
            offset = {x = 0, y = 0},
            scale = {x = hunger_levels[player:get_player_name()] * 0.01, y = 1},
            text = hunger_levels[player:get_player_name()] >= 25 and "hud_bar_green.png" or "hud_bar_red.png",
            number = 0xFFFFFF
        })
        hunger_label_ids[player:get_player_name()] = player:hud_add({
            hud_elem_type = "text",
            position = {x = 0.1, y = 0.88},
            offset = {x = 0, y = 0},
            scale = {x = 1, y = 1},
            text = "Hunger",
            number = 0x000000
        })
      
        player:hud_add({
            hud_elem_type = "image",
            position = {x = 0.1, y = 0.78},
            offset = {x = 0, y = 0},
            scale = {x = 1, y = 1},
            text = "hud_bar_bg.png",
            number = 0xFFFFFF
        })
        hp_hud_ids[player:get_player_name()] = player:hud_add({
            hud_elem_type = "image",
            position = {x = 0.1, y = 0.78},
            offset = {x = 0, y = 0},
            scale = {x = ((player:get_hp() / 20) * 100) * 0.01, y = 1},
            text = hunger_levels[player:get_player_name()] >= 10 and "hud_bar_green.png" or "hud_bar_red.png",
            number = 0xFFFFFF
        })
        hp_hud_labels[player:get_player_name()] = player:hud_add({
            hud_elem_type = "text",
            position = {x = 0.1, y = 0.78},
            offset = {x = 0, y = 0},
            scale = {x = 1, y = 1},
            text = "Health",
            number = 0x000000
        })
    end
end)

--removes the player from lists
minetest.register_on_leaveplayer(function(player)
    if player then
        local name = player:get_player_name()
        hunger_hud_ids[name] = nil
        hunger_label_ids[name] = nil
    end
end)

--updates the HUD
local function update_hud(name)
    local player = minetest.get_player_by_name(name)
    if player then
        player:hud_remove(hunger_hud_ids[name])
        player:hud_remove(hunger_label_ids[name])
        hunger_hud_ids[name] = player:hud_add({
            hud_elem_type = "image",
            position = {x = 0.1, y = 0.88},
            offset = {x = 0, y = 0},
            scale = {x = hunger_levels[player:get_player_name()] * 0.01, y = 1},
            text = hunger_levels[player:get_player_name()] >= 25 and "hud_bar_green.png" or "hud_bar_red.png",
            number = 0xFFFFFF
        })
        hunger_label_ids[player:get_player_name()] = player:hud_add({
            hud_elem_type = "text",
            position = {x = 0.1, y = 0.88},
            offset = {x = 0, y = 0},
            scale = {x = 1, y = 1},
            text = "Hunger",
            number = 0x000000
        })
      
        player:hud_remove(hp_hud_ids[name])
        player:hud_remove(hp_hud_labels[name])
        hp_hud_ids[player:get_player_name()] = player:hud_add({
            hud_elem_type = "image",
            position = {x = 0.1, y = 0.78},
            offset = {x = 0, y = 0},
            scale = {x = ((player:get_hp() / 20) * 100) * 0.01, y = 1},
            text = player:get_hp() >= 10 and "hud_bar_green.png" or "hud_bar_red.png",
            number = 0xFFFFFF
        })
        hp_hud_labels[player:get_player_name()] = player:hud_add({
            hud_elem_type = "text",
            position = {x = 0.1, y = 0.78},
            offset = {x = 0, y = 0},
            scale = {x = 1, y = 1},
            text = "Health",
            number = 0x000000
        })
    end
end

--calls the udpate HUD function
minetest.register_globalstep(function(dtime)   
    hud_timer = hud_timer + 1
    if hud_timer >= 5 then
        for _,player in pairs(minetest.get_connected_players()) do
            update_hud(player:get_player_name())
        end
        hud_timer = 0
    end
end)
