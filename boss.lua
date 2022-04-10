
require("map.map")
require("map.map_config")


Boss ={}

countdown = 300000



function Boss:load()
    index = 1
    Boss.positions={}
    Boss.length = 0
    Boss.print = false
    Boss.go = true
    --table.insert(Boss.positions,{2,3})
    --table.insert(Boss.positions,{4,5})
    --[[for i=1, 9 do
        Boss[i].positions={}
        for j = 1,20 do
            Boss[i][j]=0
        end
    end]]
    Boss.timer = 0
    Boss.life = 10
    Boss.image = love.graphics.newImage("images/boss.png")
    --Boss.positions={{1,2},{3,4},{5,6},{7,8}}
    
    
end

function timer(dt)
    countdown = countdown - dt
    if (countdown <=0)  then
        --and (index < Boss.length)
        --print(Boss.positions[index][1].." and "..Boss.positions[index][2])
        
        print(index)
        index = index + 1
        countdown = 300000
        
    end
end

function Boss:update(dt)
    if Boss.go == true then
       --[[ while true do
            
            timer(dt)
        end]]
        --[[Boss.print = true
        Boss.timer = Boss.timer + dt
        if (Boss.timer % 5) > 0 and (Boss.timer % 5) < 1 and (Boss.print == true)  then       
            --print(Boss.positions[index][1].." and "..Boss.positions[index][2])
            index = index + 1

            print(Boss.timer)

            Boss.print = false
        end]]
        
        
        for i=1 , (Boss.length - 1) do
           
            
            
            
            
                print(Boss.positions[i][1].." and "..Boss.positions[i][2])
                i = i + 1
            --love.graphics.draw(Boss.image,0,0,0)
                
            
            
        end
        --[[while true do
            if index == (Boss.length - 1) then
                break
            end
            Boss.timer = Boss.timer + dt
            if Boss.timer > 100000 then
                print(Boss.positions[index][1].." and "..Boss.positions[index][2])
                index = index+1
            end
        end]]
       Boss.go = false

    end
end


function Boss:draw()
    --[[if Boss.go == true then
        for i=1 , Boss.length - 1 do
            print(Boss.positions[i][1].." and "..Boss.positions[i][2])
            love.graphics.draw(Boss.image,0,0,0)
        end
        Boss.go = false
    end]]
    love.graphics.draw(Boss.image,Boss.positions[6][1]*48,Boss.positions[6][2]*48)
    --print(margin_y)
    --love.graphics.draw(Boss.image,0,0,0)
end