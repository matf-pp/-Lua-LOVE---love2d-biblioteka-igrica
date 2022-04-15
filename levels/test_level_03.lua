local start_image = love.graphics.newImage("images/floor_1.png")
local end_image = love.graphics.newImage("images/floor_ladder.png")
local path_image = love.graphics.newImage("images/floor_1.png")
local wall_image = love.graphics.newImage("images/wall2.png")
local spikes_image = love.graphics.newImage("images/floor_spikes_anim_f3.png")

local image_scale_factor = 1

return {
    data = {
        1,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
        4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2
    },
    images = {
        start_image = start_image,
        end_image = end_image,
        path_image = path_image,
        wall_image = wall_image,
        spikes_image = spikes_image
    },
    path_id = 3,
    wall_id = 4,
    start_id = 1,
    end_id = 2,
    spikes_id = 5,

    image_scale_factor = image_scale_factor
}