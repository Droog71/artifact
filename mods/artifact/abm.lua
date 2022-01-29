--[[
    Artifact
    Author: Droog71
    License: AGPLv3
]]--

minetest.register_abm({
    nodenames = {"artifact:rift"},
    interval = 10,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        for _, player in pairs(minetest.get_connected_players()) do
            if vector.distance(player:get_pos(), pos) <= 20 then
                player:set_pos(pos)
                player:set_hp(player:get_hp() - 5)
            end
            minetest.sound_play('rift', {
                pos = pos,
                max_hear_distance = 40
            })
            minetest.add_particlespawner({
                amount = 1,
                time = 1,
                minpos = {x=pos.x, y=pos.y + 40, z=pos.z},
                maxpos = {x=pos.x, y=pos.y + 40, z=pos.z},
                minvel = {x=0, y=0, z=0},
                maxvel = {x=0, y=0, z=0},
                minacc = {x=-0, y=0, z=-0},
                maxacc = {x=0, y=0, z=0},
                minexptime = 1,
                maxexptime = 1,
                minsize = 1000,
                maxsize = 1200,
                collisiondetection = false,
                vertical = false,
                texture = "bolt.png"
            })
        end
    end
})