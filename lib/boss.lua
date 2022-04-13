require("lib.map")
require("lib.map_config")

local index

Boss = {}

local function startMove()
    Boss.timer = 0
    Boss.go = true
    index = index + 1
    -- print(index)
end

function Boss:load()
    index = -1
    Boss.positions = {}
    Boss.length = 0
    Boss.go = false
    
    Boss.timer = 0
    Boss.life = 10
    Boss.image = love.graphics.newImage("images/boss.png")
    --Boss.positions={{1,2},{3,4},{5,6},{7,8}}

    self.should_start = false
    
    startMove()
end

local function updateBoss(dt)
    if Boss.go then
        Boss.timer = Boss.timer + dt
        if Boss.timer > 0.5 then
            Boss.go = false
        end
    end
end

function Boss:update(dt)
    if self.should_start then
        updateBoss(dt)
        if Boss.go == false then
            startMove()
        end
    end
end

function Boss:draw()
    if self.should_start then
        if index >= (Boss.length-1) then
            -- print("lose")
            love.graphics.draw(Boss.image, Boss.positions[Boss.length-1][1], Boss.positions[Boss.length-1][2])
        else
            love.graphics.draw(Boss.image, Boss.positions[index+1][1], Boss.positions[index+1][2])
        end
    else
        love.graphics.draw(Boss.image, Map.grid[1][1].x, Map.grid[1][1].y)
    end
end