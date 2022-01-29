--[[
    Hunger
    Author: Droog71
    License: AGPLv3
]]--

foods = {}
hunger_levels = {}
local hunger_timer = 0
local hunger_loaded = false

--loads data from file
local function load_hunger()
    local file = io.open(minetest.get_worldpath() .. DIR_DELIM .. "hunger.json", "r") 
    if file then
        local data = minetest.parse_json(file:read "*a")
        if data then
            if data.hunger_levels then
                hunger_levels = data.hunger_levels
            end
        else
            minetest.log("error", "Failed to read hunger.json")
        end
        io.close(file)
    end
end

--initializes the hunger variable
minetest.register_on_joinplayer(function(player)
    if player then
        if hunger_loaded == false then
            load_hunger()
        end
        if not hunger_levels[player:get_player_name()] then
            hunger_levels[player:get_player_name()] = 100
        end
    end
end)

--removes the player from lists
minetest.register_on_leaveplayer(function(player)
    if player then
        local name = player:get_player_name()
        hunger_levels[name] = nil
    end
end)

--resets hunger variable on death
minetest.register_on_dieplayer(function(player)
    local player_name = player:get_player_name()
    hunger_levels[player_name] = 100          
end)

function eat_food(itemstack, user, pointed_thing)
    local name = user:get_player_name()
    if hunger_levels[name] <= 99 and itemstack:take_item() ~= nil then
        local hunger = 100 - hunger_levels[name]
        if hunger <= 20 then
            hunger_levels[name] = hunger_levels[name] + hunger
        else
            hunger_levels[name] = hunger_levels[name] + 20
        end		  
        minetest.sound_play('eat', {
            pos = user:get_pos(),
            max_hear_distance = 8,
            gain = 0.5
        })
        return itemstack
    elseif user:get_hp() <= 20 and itemstack:take_item() ~= nil then
        local health = 20 - user:get_hp()
        if health <= 5 then               
            user:set_hp(user:get_hp() + health)    
        else
            user:set_hp(user:get_hp() + 5)
        end 
        minetest.sound_play('eat', {
            pos = user:get_pos(),
            max_hear_distance = 8,
            gain = 0.5
        })
        return itemstack
    end
end

--saves game data to file
local function save_hunger()
    local save_vars = { hunger_levels = hunger_levels }
    local save_data = minetest.write_json(save_vars)
    local save_path = minetest.get_worldpath() .. DIR_DELIM .. "hunger.json"
    minetest.safe_file_write(save_path, save_data)
end

--manages hunger for all players
function update_hunger()
    hunger_timer = hunger_timer + 1
    if hunger_timer >= 200 then
        for name, hunger_level in pairs(hunger_levels) do
            local player = minetest.get_player_by_name(name)
            if hunger_levels[name] > 0 and player:get_hp() > 0 then
                hunger_levels[name] = hunger_levels[name] - 1
            else
                if minetest.get_player_by_name(name):get_hp() > 0 then
                    hurt_player(name)
                end
            end
        end
        save_hunger()
        hunger_timer = 0
    end
end

--handles player damage and death
function hurt_player(name)
    local player = minetest.get_player_by_name(name)
    player:set_hp(player:get_hp() - 1)
end

--calls the update hunger function
minetest.register_globalstep(function(dtime)   
    update_hunger()
end)
