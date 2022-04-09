local height_ratio = 3 / 5
local margin_x, margin_y
local margin_ratio = 1 / 50

local x, y = 0, 0
local width = love.graphics.getWidth()
local height = love.graphics.getHeight() * height_ratio
local num_rows, num_columns = 9, 20
local grid_x, grid_y
local grid_width, grid_height
local field_side

margin_y = margin_ratio * love.graphics.getHeight()
grid_height = height - 2 * margin_y
field_side = grid_height / num_rows
grid_width = num_columns * field_side
margin_x = (width - grid_width) / 2
grid_x = x + margin_x
grid_y = y + margin_y

return {
    x = x,
    y = y,
    width = width,
    height = height,
    num_rows = num_rows,
    num_columns = num_columns,
    grid_x = grid_x,
    grid_y = grid_y,
    grid_width = grid_width,
    grid_height = grid_height,
    field_side = field_side
}