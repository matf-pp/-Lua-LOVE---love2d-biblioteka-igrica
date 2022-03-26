require("map")
require("shop")
require("menu")

function love.load()
    Map:load()
    Shop:load()
    Menu:load()
end

function love.update(dt)
    Map:update(dt)
    Shop:update(dt)
    Menu:update(dt)
end

function love.draw()
    Map:draw()
    Shop:draw()
    Menu:draw()
end