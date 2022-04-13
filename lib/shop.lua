require("lib.map")

BUTTON_WIDTH = 48

local level_data = require("levels.test_level_01")

local function new_button(text,fn)
    return{
        text = text,
        fn = fn,

        select = false,
        now = false,
        last = false
    }
end

Shop = {}

function Shop:load()
    --[[
        Postavljene samo bazicne karakteristike shop-a
        Ako ubacujemo i menu u igru, potrebno promeniti shop tkd. staje i menu pored njega
        ... TODO ...
    --]]

    table.insert(Shop,new_button(
        "wall_button",
        function()
            print("uspesno pritisnuto wall dugme")
            
            
        end)
        
    )
    
    table.insert(Shop,new_button(
        "spike_button",
        function()
            print("uspesno pritisnuto spike dugme")
            
        end)
    )

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
    if Shop[1].select == true and love.mouse.isDown(2) then
            local dx,dy =  love.mouse.getPosition()
            if Map:add_wall(dx,dy) == true then 
                print("Uspesno dodat zid na koordinatama ( "..dx.." , "..dy.." )")
                Shop[1].select = false
            else
                print("Neuspesno dodavanje zida na koordinatama (70, 30)")
            end
        

    end

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
    love.graphics.setColor(1, 1, 1)
    --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    

    local margin = 16
    local total_width = (BUTTON_WIDTH + margin) * #Shop
    local cursor_x = 0

    for i,button in ipairs(Shop) do 
        button.last = button.now

        local bx = self.x + 50 + cursor_x
        local by = self.y + 50

        local mx,my = love.mouse.getPosition()

        local hot = mx > bx and mx < bx + 48 and
                    my > by and my < by + BUTTON_HEIGHT

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            
            button.fn()
            button.select = true
        end
        
        love.graphics.draw(level_data.images.wall_image,bx,by)

        cursor_x = cursor_x + BUTTON_HEIGHT+margin

    end
    
    




    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.shop_font)
    love.graphics.print("Shop", self.x + 5, self.y + 5)
end