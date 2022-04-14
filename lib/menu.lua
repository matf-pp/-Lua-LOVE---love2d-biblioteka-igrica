local menu_data = require("lib.menu_config")

Menu = {}
local font = nil

function Menu:new_button(text, fn, num)
    local x, y
    local width, height
    local color, color_normal, color_hover

    local margin_y

    width = self.width * 9 / 10
    height = self.height * 2 / 10
    margin_y = (self.height - self.num_buttons * height) / (self.num_buttons + 1)
    x = self.x + (self.width - width) / 2
    y = self.y + margin_y * num + height * (num - 1)

    color_normal = {0.4, 0.4, 0.5, 1.0}
    color_hover = {0.8, 0.8, 0.9, 1.0}
    color = color_normal

    local button = {
        x = x,
        y = y,
        width = width,
        height = height,
        text = text,
        fn = fn,
        now = false,
        last = false,
        color = color,
        color_normal = color_normal,
        color_hover = color_hover
    }

    function button:draw()
        -- crtanje dugmeta
        love.graphics.setColor(unpack(self.color))
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 10, 10)

        -- pisanje teksta na dugmetu
        love.graphics.setColor(0, 0, 0, 1)
        local text_width = font:getWidth(button.text)
        local text_height = font:getHeight(button.text)
        love.graphics.print(
            button.text,
            font,
            self.x + self.width / 2,
            self.y + self.height / 2,
            0,
            1,
            1,
            text_width / 2,
            text_height / 2
        )
    end

    function button:update()
        -- resetovanje stanja dugmeta
        self.last = self.now
        
        -- hvatanje pozicije kursora
        local mx, my = love.mouse.getPosition()
        local hot = mx > self.x and mx < self.x + self.width and my > self.y and my < self.y + self.height

        -- boja dugmeta
        self.color = self.color_normal
        if hot then 
            self.color = self.color_hover
        end

        -- klik na dugme (pozivanje funkcionalnosti dugmeta)
        self.now = love.mouse.isDown(1)
        if self.now and not self.last and hot then
            self.fn()
        end
    end

    return button
end

local function start_function()
    print("Starting game")
    local path = Map:find_path()
    
    local i = 1
    if next(path) == nil then
        print("path not found")
    else
        print("path found:")
        for _, value in pairs(path) do
            io.write(value.to_string .. " -> ")
            table.insert(
                Boss.positions,
                {
                    value.x,
                    value.y
                }
            )
            i = i + 1
        end
        print("done")

        Boss.length = i
        Boss.should_start = true
    end
end

local function reset_function()
    print("Resetting level")
end

local function load_function()
    print("Pick a level")
end

local function exit_function()
    love.event.quit(0)
end

--da li raditi change the scene ili ostati sve na jednom ekranu?
function Menu:load()
    font = love.graphics.newFont(32)

    self.x = love.graphics.getWidth() * 3 / 5
    self.y = love.graphics.getHeight() * 3 / 5
    self.width = love.graphics.getWidth() * 2 / 5
    self.height = love.graphics.getHeight() * 2 / 5
    
    self.buttons = {}
    self.num_buttons = 4
    self.buttons.start = self:new_button("start", start_function, 1)
    self.buttons.reset = self:new_button("reset", reset_function, 2)
    self.buttons.load = self:new_button("load", load_function, 3)
    self.buttons.exit = self:new_button("exit", exit_function, 4)
end

function Menu:update(dt)
    for _, button in pairs(self.buttons) do
        button:update()
    end
end

function Menu:draw()
    -- cratnje glavnog prozora
    love.graphics.setColor(0.5, 0.2, 0.8)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- crtanje dugmica
    for _, button in pairs(self.buttons) do
        button:draw()
    end
end