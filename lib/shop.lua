require("lib.map")
local level_data = require("levels.test_level_01")
local shop_data = require("lib.shop_config")

--[[
    Funkcija uzima string text i funkciju fn i pravi table sa podacima o dugmetu, gde je text ime dugmeta, a fn njegova funkcionalnost.
]]
local function new_button(text, fn)
    return {
        text = text,
        fn = fn,
        select = false,
        now = false,
        last = false
    }
end

Shop = {}

function Shop:load()
    -- koordinate gornjeg levog ugla shop-a
    self.x, self.y = shop_data.x, shop_data.y
    -- sirina i visina shop-a
    self.width, self.height = shop_data.width, shop_data.height
    -- font koji se koristi u shop-u
    self.shop_font = shop_data.shop_font
    -- dugmici u shop-u
    self.buttons = {}

    table.insert(
        self.buttons,
        new_button(
            "wall_button",
            function()
                print("uspesno pritisnuto wall dugme")
            end
        )
    )

    table.insert(
        self.buttons,
        new_button(
            "spike_button",
            function()
                print("uspesno pritisnuto spike dugme")
            end
        )
    )

    self.buttons.wall = new_button(
        "wall_button",
        function ()
            print("halo, dobar dan")
        end
    )
end

function Shop:update(dt)
    -- TODO
    if self.buttons.wall.select == true and love.mouse.isDown(2) then
        print("Juhu!")
        --[[
        local dx, dy =  love.mouse.getPosition()
        if Map:add_wall(dx,dy) == true then 
            print("Uspesno dodat zid na koordinatama ( "..dx.." , "..dy.." )")
            self.buttons[1].select = false
        else
            print("Neuspesno dodavanje zida na koordinatama (70, 30)")
        end
        ]]
    end
end

function Shop:draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1)

    local button_width = 48
    local button_height = 48

    local margin = 16
    local total_width = (button_width + margin) * #self.buttons
    local cursor_x = 0

    for _, button in pairs(self.buttons) do
        button.last = button.now

        local bx = self.x + 50 + cursor_x
        local by = self.y + 50

        local mx, my = love.mouse.getPosition()

        local hot = mx > bx and mx < bx + button_width and
                    my > by and my < by + button_height

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button.fn()
            button.select = true
        end

        love.graphics.draw(level_data.images.wall_image, bx, by)

        cursor_x = cursor_x + button_width + margin
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.shop_font)
    love.graphics.print("Shop", self.x + 5, self.y + 5)
end