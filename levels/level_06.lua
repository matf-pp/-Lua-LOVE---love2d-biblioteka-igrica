love.graphics.setDefaultFilter("nearest", "nearest")
local start_image = love.graphics.newImage("images/floor_1.png")
local end_image = love.graphics.newImage("images/floor_ladder.png")
local path_image = love.graphics.newImage("images/floor_1.png")
local wall_image = love.graphics.newImage("images/wall2.png")
local spikes_image_0 = love.graphics.newImage("images/floor_spikes_anim_f0.png")
local spikes_image_1 = love.graphics.newImage("images/floor_spikes_anim_f1.png")
local spikes_image_2 = love.graphics.newImage("images/floor_spikes_anim_f2.png")
local spikes_image_3 = love.graphics.newImage("images/floor_spikes_anim_f3.png")
local boss_idle_0 = love.graphics.newImage("images/chort_idle_anim_f0.png")
local boss_idle_1 = love.graphics.newImage("images/chort_idle_anim_f1.png")
local boss_idle_2 = love.graphics.newImage("images/chort_idle_anim_f2.png")
local boss_idle_3 = love.graphics.newImage("images/chort_idle_anim_f3.png")
local boss_run_0 = love.graphics.newImage("images/chort_run_anim_f0.png")
local boss_run_1 = love.graphics.newImage("images/chort_run_anim_f1.png")
local boss_run_2 = love.graphics.newImage("images/chort_run_anim_f2.png")
local boss_run_3 = love.graphics.newImage("images/chort_run_anim_f3.png")

return {
    grid_data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 4, 3, 4, 3, 3, 4, 3, 3, 4, 3, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 3, 1, 3, 3, 3, 4, 3, 3, 3, 3, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 4, 3, 4, 3, 3, 4, 3, 3, 4, 3, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 3, 3, 3, 3, 3, 4, 3, 3, 3, 2, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    },
    images = {
        start_image = start_image,
        end_image = end_image,
        path_image = path_image,
        wall_image = wall_image,
        spikes_image_0 = spikes_image_0,
        spikes_image_1 = spikes_image_1,
        spikes_image_2 = spikes_image_2,
        spikes_image_3 = spikes_image_3,
        boss = {
            boss_idle_0 = boss_idle_0,
            boss_idle_1 = boss_idle_1,
            boss_idle_2 = boss_idle_2,
            boss_idle_3 = boss_idle_3,
            boss_run_0 = boss_run_0,
            boss_run_1 = boss_run_1,
            boss_run_2 = boss_run_2,
            boss_run_3 = boss_run_3
        }
    },
    path_id = 3,
    wall_id = 4,
    start_id = 1,
    end_id = 2,
    spikes_id = 5,
    shop = {
        starting_money = 3,
        available_buttons = {
            --wall = {},
            spikes = {}
        }
    },
    boss = {
        starting_health = 3
    }
}