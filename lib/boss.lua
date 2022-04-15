require("lib.map")
require("lib.map_config")

love.graphics.setDefaultFilter("nearest", "nearest")
local boss_idle_0 = love.graphics.newImage("images/chort_idle_anim_f0.png")
local boss_idle_1 = love.graphics.newImage("images/chort_idle_anim_f1.png")
local boss_idle_2 = love.graphics.newImage("images/chort_idle_anim_f2.png")
local boss_idle_3 = love.graphics.newImage("images/chort_idle_anim_f3.png")
local boss_run_0 = love.graphics.newImage("images/chort_run_anim_f0.png")
local boss_run_1 = love.graphics.newImage("images/chort_run_anim_f1.png")
local boss_run_2 = love.graphics.newImage("images/chort_run_anim_f2.png")
local boss_run_3 = love.graphics.newImage("images/chort_run_anim_f3.png")
local quad = love.graphics.newQuad(0, 0, 16, 24, 16, 24)

local index

Boss = {}

function Boss:start_move()
    self.timer = 0
    self.go = true
    index = index + 1
end

function Boss:load()
    index = -1
    self.positions = {}
    self.length = 0
    self.go = false
    
    self.timer = 0
    self.image = boss_idle_0

    self.phase = "idle"
    self.position = {
        x = Map.start_field.x,
        y = Map.start_field.y
    }
    self.clock = 0
    
    self:start_move()
end

function Boss:update_image(dt)
    self.clock = self.clock + dt
    if self.phase == "idle" then
        if self.clock >= 0 and self.clock < 0.25 then
            self.image = boss_idle_0
        elseif self.clock >= 0.25 and self.clock < 0.5 then
            self.image = boss_idle_1
        elseif self.clock >= 0.5 and self.clock < 0.75 then
            self.image = boss_idle_2
        elseif self.clock >= 0.75 and self.clock < 1 then
            self.image = boss_idle_3
        else
            self.clock = 0
        end
    end
    if self.phase == "run" then
        if self.clock >= 0 and self.clock < 0.15 then
            self.image = boss_run_0
        elseif self.clock >= 0.15 and self.clock < 0.3 then
            self.image = boss_run_1
        elseif self.clock >= 0.3 and self.clock < 0.45 then
            self.image = boss_run_2
        elseif self.clock >= 0.45 and self.clock < 0.6 then
            self.image = boss_run_3
        else
            self.clock = 0
        end
    end
end

function Boss:update_position(dt)
    if self.phase == "run" and self.go then
        self.timer = self.timer + dt
        if self.timer > 0.5 then
            self.go = false
            self:start_move()
        end
    end

    if self.phase == "run" then
        if index >= (self.length-1) then
            -- lose
            self.position.x = self.positions[self.length-1][1]
            self.position.y = self.positions[self.length-1][2]

            self.phase = "idle"
        else
            self.position.x = self.positions[index+1][1]
            self.position.y = self.positions[index+1][2]
        end
    end
end

function Boss:update(dt)
    self:update_position(dt)
    self:update_image(dt)
end

function Boss:draw()
    love.graphics.draw(self.image, quad, self.position.x, self.position.y - 24, 0, 3, 3)
end