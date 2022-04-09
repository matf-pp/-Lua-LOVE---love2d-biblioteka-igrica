require("map")
require("shop")
require("menu")
require("boss")

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
    --Bitan redosled
    Boss:draw()
    Shop:draw()
    Menu:draw()
    
end