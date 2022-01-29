--[[
    Artifact
    Author: Droog71
    License: AGPLv3
]]--
 
--increases player speed when aux1 key is pressed
minetest.register_globalstep(function(dtime)  
    for _,player in pairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        if player:get_player_control().aux1 then
            player:set_physics_override({speed = 1.8})
        else
            player:set_physics_override({speed = 1})
        end
    end
end)