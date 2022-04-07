require("map.map")

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

local start_debug = true

function Shop:update(dt)
    -- TODO

    -- test (Robert):
    --[[        
        if start_debug == true then
            if Map:add_wall(70, 30) == true then
                print("Uspesno dodat zid na koordinatama (70, 30)")
            else
                print("Neuspesno dodavanje zida na koordinatama (70, 30)")
            end
            
            if Map:add_wall(250, 30) == true then
                print("Uspesno dodat zid na koordinatama (250, 30)")
            else
                print("Neuspesno dodavanje zida na koordinatama (250, 30)")
            end

            if Map:add_wall(200, 100) == true then
                print("Uspesno dodat zid na koordinatama (200, 300)")
            else
                print("Neuspesno dodavanje zida na koordinatama (200, 300)")
            end
        end
        start_debug = false
    ]]
end

function Shop:draw()
    -- TODO
    love.graphics.setColor(235.255, 116/255, 52/255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(self.shop_font)
    love.graphics.print("Shop", self.x + 5, self.y + 5)
end