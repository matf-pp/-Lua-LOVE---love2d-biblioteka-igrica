require ("levels.testLvl")

local map_images
local wall
local path
local start

Map = {}

function Map:load()
    -- Pomocne promenljive za podesavanje mape
    local height_ratio = 3 / 5
    local margin_x, margin_y
    local margin_ratio = 1 / 50

    map_images = require("levels.testLvl")

    wall = love.graphics.newImage("images/wall.png")
    path = love.graphics.newImage("images/path.png")
    start = love.graphics.newImage("images/start.png")

    --[[
        Karakteristike mape:
        x, y - koordinate gornjeg levog ugla mape (gledano kao prozora)
        width, height - sirina i visina mape (isto gledano kao prozora)
        m, n - broj vrsta i broj kolona
        grid_x, grid_y - koordinate gornjeg levog ugla grid-a odn. onog dela mape gde se nalaze polja
        grid_width, gird_height - sirina i visina grid-a
        field_size - duzina stranice polja (polje = kvadrat)
    --]]
    self.x = 0
    self.y = 0
    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight() * height_ratio
    self.m = 9
    self.n = 20
    margin_y = margin_ratio * love.graphics.getHeight()
    self.grid_height = self.height - 2 * margin_y
    self.field_side = self.grid_height / self.m
    self.grid_width = self.n * self.field_side
    margin_x = (self.width - self.grid_width) / 2
    self.grid_x = self.x + margin_x
    self.grid_y = self.y + margin_y

    --[[
        Grid sam zamislio da bude poseban deo koji se odnosi na polja mape odn. koji ce biti
        po svojoj strukturi graf u kome su cvorovi polja mape. Polja sadrze odredjene podatke,
        a algoritam i ostale stvari bi se implementirale nad grid-om.
        Grid je, dakle, niz vrsta, a svaka vrsta je niz polja.
        Polje ce imati podatke koji ce biti korisni za dalju implementaciju, poput:
            - podataka o redu i koloni u grid-u
            - podataka o susedima
            - posecenosti polja
            - tipu polja
            ...
    --]]
    self.grid = {}
    for i = 1, self.m, 1 do
        self.grid[i] = {}
        for j = 1, self.n, 1 do
            self.grid[i][j] = {}
            self.grid[i][j].row = i
            self.grid[i][j].column = j

            self.grid[i][j].to_string = "cvor " .. i .. " " .. j
            self.grid[i][j].neighbors = {}
            self.grid[i][j].visited = false
            self.grid[i][j].distance = -1
            self.grid[i][j].previous = nil

            self.grid[i][j].x = self.grid_x + (self.grid[i][j].column - 1) * self.field_side
            self.grid[i][j].y = self.grid_y + (self.grid[i][j].row - 1) * self.field_side
        end
    end

    -- Kroz ovu petlju se postavljaju grane grafa, odn. svakom cvoru se dodeljuju susedi
    for i = 1, self.m, 1 do
        for j = 1, self.n, 1 do
            local index = 0
            if self.grid[i-1] ~= nil then
                index = index + 1
                self.grid[i][j]["neighbors"][index] = self.grid[i-1][j]
            end
            if self.grid[i+1] ~= nil then
                index = index + 1
                self.grid[i][j]["neighbors"][index] = self.grid[i+1][j]
            end
            if self.grid[i][j-1] ~= nil then
                index = index + 1
                self.grid[i][j]["neighbors"][index] = self.grid[i][j-1]
            end
            if self.grid[i][j+1] ~= nil then
                index = index + 1
                self.grid[i][j]["neighbors"][index] = self.grid[i][j+1]
            end
        end
    end
end

Go = true

function Map:update(dt)
    -- TODO
    Contents = {}
    
    if Go == true then
        local path = self:find_path(1, 1, 3, 2) 
        for i = #path, 1, -1 do
            print(path[i].to_string)
        end
        Go = false
    end
end

--[[
    Funkcija uzima "cvorove" A i B i pokusava da nadje najkraci put od A do B.
--]]
function Map:find_path(i1, j1, i2, j2)
    Queue = {}

    function Queue.new()
      return {first = 0, last = -1}
    end
    
    function Queue.push(queue, value)
      local last = queue.last + 1
      queue.last = last
      queue[last] = value
    end
    
    function Queue.pop(queue)
      local first = queue.first
      if first > queue.last then error("queue is empty") end
      local value = queue[first]
      queue[first] = nil
      queue.first = first + 1
      return value
    end

    function Queue.is_empty(queue)
        if queue.first > queue.last then
            return true
        end
        return false
    end

    function Queue.contains(queue, value)
        for _, v in pairs(queue) do
            if v == value then
                return true
            end
        end
        return false
    end

    local queue = Queue.new()
    local start = self.grid[i1][j1]

    start.distance = 0
    Queue.push(queue, start)

    while Queue.is_empty(queue) == false do
        local current = Queue.pop(queue)
        local distance = current.distance
        current.visited = true
        
        for _, neighbor in pairs(current.neighbors) do
            if neighbor.visited == false and Queue.contains(queue, neighbor) == false then
                if neighbor.previous == nil then
                    neighbor.distance = distance + 1
                    neighbor.previous = current
                elseif neighbor.distance > distance + 1 then
                    neighbor.distance = distance + 1
                    neighbor.previous = current
                end
                Queue.push(queue, neighbor)
            end
        end
    end

    local result = {}
    local current = self.grid[i2][j2]
    while current.previous ~= nil do
        table.insert(result, current)
        current = current.previous
    end
    table.insert(result, start)

    for i = 1, self.m, 1 do
        for j = 1, self.n, 1 do
            self.grid[i][j].visited = false
            -- TODO: obrisati
            -- print(self.grid[i][j].to_string .. ": " .. self.grid[i][j].distance)
            self.grid[i][j].distance = -1
            -- print(self.grid[i][j].to_string .. ": " .. self.grid[i][j].previous)
            self.grid[i][j].previous = nil
        end
    end

    return result
end

function Map:draw()
    -- Pozadina cele mape
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- Pozadina grid-a
    love.graphics.setColor(36/255, 64/255, 201/255)
    love.graphics.rectangle("fill", self.grid_x, self.grid_y, self.grid_width, self.grid_height)

    -- TMP: ispis za proveru find_path funkcije
    love.graphics.setColor(1, 0, 0)
    for index, value in pairs(Contents) do
        print(value)
    end
    
    -- Crtanje polja grid-a
    love.graphics.setColor(224/255, 235/255, 38/255)
    local i = 1
    for _, row in pairs(self.grid) do
        for _, field in pairs(row) do
            if map_images.data[i] == 1 then
                love.graphics.draw(start, field.x, field.y)
            elseif map_images.data[i] == 2 then
                love.graphics.draw(wall, field.x, field.y)
            elseif map_images.data[i] == 3 then
                love.graphics.draw(path, field.x, field.y)
            else
                love.graphics.rectangle("line", field.x, field.y, self.field_side, self.field_side)
            end
            i=i+1
        end
    end
end