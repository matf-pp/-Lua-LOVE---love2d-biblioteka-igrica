local menu_data = require("lib.menu_config")
level_data = require("lib.level_data")

Menu = {}
local font = nil

local function pick_lvl()
    local buttons = {"LVL8","LVL7","LVL6","LVL5","LVL4","LVL3","LVL2","LVL1"}
    local pressedbutton = love.window.showMessageBox( 'Levels', "Pick a level you want to play:",buttons, info, true)
    
    if pressedbutton == 8 then
        print("picked lvl1")
        level_data = require("levels.level_01")
        love.load()
    elseif pressedbutton == 7 then
        print("picked lvl2")
        level_data = require("levels.level_02")
        love.load()
    elseif pressedbutton == 6 then
        print("picked lvl3")
        level_data = require("levels.level_03")
        love.load()
    elseif pressedbutton == 5 then
        print("picked lvl4")
        level_data = require("levels.level_04")
        love.load()
    elseif pressedbutton == 4 then
        print("picked lvl5")
        level_data = require("levels.level_05")
        love.load()
    elseif pressedbutton == 3 then
        print("picked lvl6")
        level_data = require("levels.level_06")
        love.load()
    elseif pressedbutton == 2 then
        print("picked lvl7")
        level_data = require("levels.level_07")
        love.load()
    elseif pressedbutton == 1 then
        print("picked lvl8")
        level_data = require("levels.level_08")
        love.load()
    end
end

function Menu:new_button(text, fn, num)
    local x, y
    local width, height
    local color, color_normal, color_hover

    local margin_y

    width = self.width * 9 / 10
    height = self.height * 1.3 / 10
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
    local buttons = {"Another Level","Try again"}

    if next(path) == nil then
        print("path not found")
        local pressedbutton = love.window.showMessageBox( 'Congratulations', "Would you like to try again or pick another level?",buttons, info, true)
        if pressedbutton == 1 then
            pick_lvl()
        elseif pressedbutton == 2 then
            love.load()
        end
    else
        local length = 1
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
            length = length + 1
        end
        print("done")

        Boss.length = length
        Boss.phase = "run"
    end
end

local function reset_function()
    love.load()
end

local function load_function()
    pick_lvl()
end

local function exit_function()
    local buttons = {"No","Yes"}
    local pressedbutton = love.window.showMessageBox( 'Warning', "Are you sure you want to exit the game?",buttons, info, true)
    if pressedbutton == 2 then
        love.event.quit(0)
    end
end

local function about_function()
    local buttons = {"Ok"}
    local pressedbutton = love.window.showMessageBox( 'About us:', "The creators of this project are Robert Doža and Luka Sparić, students from the Faculty of Mathematics in Belgrade."
                                                        .."\n"
                                                        .."\n We wanted to make a game that would use some sort of graph algorithm that we learnt in class. "
                                                        .."\n We agreed on using a basic, 'find all paths' graph algorithm based on DFS (depth-first search) for finding the correct path."
                                                        .."\n Utilizing only this algorithm we managed to make a mini game that totally relies on it. Of course, there is a lot of space for improvement in the future."
                                                        .."\n"
                                                        .."\n We hope you enjoy the game! :D",buttons, info, true)
    if pressedbutton == 1 then
    end
end

local function help_function()
    local buttons = {"Ok"}
    local pressedbutton = love.window.showMessageBox( 'Rules of the game:',
                                                            " In this puzzle game, there is a monster on one field of the map, and it wants to escape using the ladders on another field."
                                                            .."\n The monster can move up, down, left and right. It will not try to move immediately though, only when you press the 'Start level' button."
                                                            .."\n Your goal is to cleverly place certain obstacles on the map that will prevent the monster from reaching the ladders."
                                                            .."\n"
                                                            .."\n In order to place obstacles on the map, you need to purchase them in the shop."
                                                            .."\n There, you can see which obstacles are available and how much they cost. There are two types of obstacles:"
                                                            .."\n - walls that completely block a field, rendering it impassable;"
                                                            .."\n - spikes that reduce the monster's health points by 1 (the monster has 3 health points at the start, "
                                                            .."\n    which essentially means that it can't pass over more than 2 spikes)"
                                                            .."\n"
                                                            .."\n Left-click an obstacle to select it. Details of the selected obstacle, as well as its cost will appear in the shop."
                                                            .."\n Then, right-click on the map to place the selected obstacle."
                                                            .."\n"
                                                            .."\n If at any point you make a mistake, you can always click the 'Reset level' button to reset the configuration of the map."
                                                            .."\n"
                                                            .."\n If you are satisfied with how you placed the obstacles, press 'Start level' and hope for the best!"
                                                            .."\n"
                                                            .."\n Good luck and have fun!",buttons, info, true)
        if pressedbutton == 1 then
        end
end

function Menu:load()
    font = love.graphics.newFont(30)

    self.x = menu_data.x
    self.y = menu_data.y
    self.width = menu_data.width
    self.height = menu_data.height
    
    self.buttons = {}
    self.num_buttons = 6
    self.buttons.help = self:new_button("Instructions", help_function, 1)
    self.buttons.start = self:new_button("Start level", start_function, 2)
    self.buttons.reset = self:new_button("Reset level", reset_function, 3)
    self.buttons.load = self:new_button("Select level", load_function, 4)
    self.buttons.about = self:new_button("About the game", about_function, 5)
    self.buttons.exit = self:new_button("Exit game", exit_function, 6)
end

function Menu:update(dt)
    for _, button in pairs(self.buttons) do
        button:update()
    end
end

function Menu:draw()
    -- crtanje pozadine
    local bg_image = love.graphics.newImage("images/wall2.png")
    bg_image:setWrap("repeat", "repeat")
    local bg_quad = love.graphics.newQuad(0, 0, self.width, self.height, 48, 48)

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(bg_image, bg_quad, self.x, self.y, 0, 1, 1)
    -- crtanje dugmica
    for _, button in pairs(self.buttons) do
        button:draw()
    end
end