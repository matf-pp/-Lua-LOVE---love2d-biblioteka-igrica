local start_image = love.graphics.newImage("images/start.png")
local end_image = love.graphics.newImage("images/start.png")
local path_image = love.graphics.newImage("images/path.png")
local wall_image = love.graphics.newImage("images/wall.png")

return {
    data = {
        1,3,3,3,3,3,3,3,3,3,4,4,4,3,3,3,3,3,3,3,
        3,4,3,4,4,3,4,3,4,3,3,4,3,3,4,4,3,4,4,3,
        3,4,3,4,3,3,3,4,4,4,3,4,3,3,3,3,3,3,4,3,
        3,4,3,3,4,4,3,3,3,3,3,3,3,4,4,4,3,3,3,3,
        3,3,3,3,3,3,3,4,4,3,3,4,3,4,3,4,3,4,4,4,
        3,4,3,4,4,4,3,4,3,3,3,4,3,4,4,4,3,3,3,3,
        3,4,3,4,3,3,3,3,3,4,4,3,3,3,3,4,3,3,4,4,
        3,4,4,4,3,4,3,4,3,4,3,3,4,3,3,3,4,3,3,4,
        3,3,3,3,3,3,3,4,3,4,3,3,4,3,4,3,4,4,3,2
    },
    images = {
        start_image = start_image,
        end_image = end_image,
        path_image = path_image,
        wall_image = wall_image
    },
    path_id = 3,
    wall_id = 4,
    start_id = 1,
    end_id = 2
}