Shop = {}

function Shop:load()
    --[[
        Postavljene samo bazicne karakteristike shop-a
        Ako ubacujemo i menu u igru, potrebno promeniti shop tkd. staje i menu pored njega
        ... TODO ...
    --]]
    self.x = 0
    local height_ratio = 3 / 5
    self.y = love.graphics.getHeight() * height_ratio
    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight() * (1 - height_ratio)
    self.shop_font = love.graphics.newFont(14)
end

function Shop:update(dt)
    -- TODO
end

function Shop:draw()
    -- TODO
    love.graphics.setColor(235.255, 116/255, 52/255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(self.shop_font)
    love.graphics.print("Shop", self.x + 5, self.y + 5)
end