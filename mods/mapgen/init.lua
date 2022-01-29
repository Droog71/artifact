--[[
    Artifact
    Droog71
    License: AGPLv3
]]--

local ores = {
    "artifact:stone_with_coal",
    "artifact:stone_with_iron",
    "artifact:stone_with_copper",
    "artifact:stone_with_tin",
    "artifact:stone_with_gold"
}

local decorations = {
    "artifact:rock",
    "artifact:plant",
    "artifact:tree",
    "artifact:tree_2",
    "artifact:tree_3",
    "artifact:tree_4"
}

minetest.register_on_generated(function(minp, maxp, blockseed)
    if minp.y > 0 or maxp.y < 0 then return end
    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()
    for z = minp.z, maxp.z do
        for x = minp.x, maxp.x do
            for y = 0, 0, 1 do
                local rand_ore = math.random(1,1000)
                if rand_ore >= 999 then
                    local rand_node = math.random(1,6)
                    local vi = area:index(x, y, z)
                    data[area:index(x, y, z)] = minetest.get_content_id(decorations[rand_node])
                end
            end
            for y = -2,-1,1 do
                local vi = area:index(x, y, z)
                local rand_node = math.random(1,100)
                if rand_node >= 5 then
                    data[area:index(x, y, z)] = minetest.get_content_id("artifact:grass")
                else
                    data[area:index(x, y, z)] = minetest.get_content_id("artifact:stone")
                end
            end
            for y = -10,-3,1 do
                local vi = area:index(x, y, z)
                data[area:index(x, y, z)] = minetest.get_content_id("artifact:stone")
            end
            for y = -43,-10,1 do
                local vi = area:index(x, y, z)
                local rand_gen = math.random(1,100)
                if rand_gen >= 25 then
                    data[area:index(x, y, z)] = minetest.get_content_id("artifact:stone")
                else
                    local rand_ore = math.random(1,100)
                    if rand_ore >= 25 then
                        local rand_node = math.random(1,5)
                        data[area:index(x, y, z)] = minetest.get_content_id(ores[rand_node])
                    else
                        data[area:index(x, y, z)] = minetest.get_content_id("artifact:stone")
                    end
                end
            end
            for y = -45, -44, 1 do
                data[area:index(x, y, z)] = minetest.get_content_id("artifact:bedrock")
            end
        end
    end
    vm:set_data(data)
    vm:write_to_map(data)
end)