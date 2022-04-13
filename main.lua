require("lib.map")
require("lib.shop")
require("lib.menu")
require("lib.boss")

function love.load()
    Map:load()
    Shop:load()
    Menu:load()
    Boss:load()
end

function love.update(dt)
    Map:update(dt)
    Shop:update(dt)
    Menu:update(dt)
    Boss:update(dt)
end

function love.draw()
    Map:draw()
    Boss:draw()
    Shop:draw()
    Menu:draw()
end