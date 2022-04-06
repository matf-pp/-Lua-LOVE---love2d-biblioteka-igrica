local map_data = require ("levels.testLvl")

Map = {}

function Map:load()
    -- Pomocne promenljive za podesavanje mape
    local height_ratio = 3 / 5
    local margin_x, margin_y
    local margin_ratio = 1 / 50

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
    local k = 1
    self.grid = {}
    for i = 1, self.m, 1 do
        self.grid[i] = {}
        for j = 1, self.n, 1 do
            self.grid[i][j] = {}
            local field = self.grid[i][j]

            -- opsti podaci
            field.row = i
            field.column = j

            -- podaci potrebni za svrhe algoritama
            field.to_string = "cvor " .. i .. " " .. j
            field.neighbors = {}
            field.visited = false
            field.distance = -1
            field.previous = nil

            field.has_wall = false
            field.is_start = false
            field.is_end = false

            if map_data.data[k] == map_data.wall_id then
                field.has_wall = true
            end

            if map_data.data[k] == map_data.start_id then
                field.is_start = true
            end

            if map_data.data[k] == map_data.end_id then
                field.is_end = true
            end

            k = k + 1

            -- podaci potrebni za grafiku
            field.x = self.grid_x + (field.column - 1) * self.field_side
            field.y = self.grid_y + (field.row - 1) * self.field_side
        end
    end

    -- Kroz ovu petlju se postavljaju grane grafa, odn. svakom cvoru se dodeljuju susedi
    for i = 1, self.m, 1 do
        for j = 1, self.n, 1 do
            local current = self.grid[i][j]
            current.neighbors = {}
            
            -- up
            if self.grid[i-1] ~= nil then
                local up = self.grid[i-1][j]
                if up.has_wall == false then
                    table.insert(current.neighbors, up)
                end
            end

            -- down
            if self.grid[i+1] ~= nil then
                local down = self.grid[i+1][j]
                if down.has_wall == false then
                    table.insert(current.neighbors, down)
                end
            end

            -- left
            local left = self.grid[i][j-1]
            if left ~= nil then
                if left.has_wall == false then
                    table.insert(current.neighbors, left)
                end
            end

            -- right
            local right = self.grid[i][j+1]
            if right ~= nil then
                if right.has_wall == false then
                    table.insert(current.neighbors, right)
                end
            end
        end
    end
end

--[[
    Funkcija prima koordinate klika na ekranu. Ako je kliknuto na polje na grid-u, radi sledece:
    - ako je u pitanju path, postavlja wall;
    - ako je u pitanju wall, start ili end, ne radi nista;
    itd.
    Povratna vrednost je tipa bool i predstavlja uspeh pri postavljanju wall-a:
    - ako je uspelo, vraca true,
    - u suprotnom, false
]]
function Map:add_wall(x, y)
    local dx = x - self.grid_x
    local dy = y - self.grid_y
    local i = math.floor(dy / self.field_side) + 1
    local j = math.floor(dx / self.field_side) + 1

    if i <= 0 or i > self.m or j <= 0 or j > self.n then
        return false
    end

    self.grid[i][j].has_wall = true

    return true
end

local start_debug = true
local delete_me = {}

function Map:update(dt)
    -- TODO
    if start_debug == true then
        local path = self:find_path(1, 1, 9, 20) 
        if next(path) == nil then
            print("path not found")
        else
            print("path found:")
            for i = #path, 1, -1 do
                io.write(path[i].to_string .. " -> ")
            end
            print("done")
        end

        for _, value in pairs(delete_me) do
            print(value)
        end

        start_debug = false
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
    if current.previous ~= nil then
        while current.previous ~= nil do
            table.insert(result, current)
            current = current.previous
        end 
        table.insert(result, start)
    end

    for i = 1, self.m, 1 do
        for j = 1, self.n, 1 do
            self.grid[i][j].visited = false
            self.grid[i][j].distance = -1
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

    -- Crtanje polja grid-a
    local wall_image = love.graphics.newImage("images/wall.png")
    local path_image = love.graphics.newImage("images/path.png")
    local start_image = love.graphics.newImage("images/start.png")
    local end_image = love.graphics.newImage("images/start.png")

    love.graphics.setColor(224/255, 235/255, 38/255)

    for _, row in pairs(self.grid) do
        for _, field in pairs(row) do
            if field.is_start then
                love.graphics.draw(start_image, field.x, field.y)
            elseif field.is_end then
                love.graphics.draw(end_image, field.x, field.y)
            elseif field.has_wall then
                love.graphics.draw(wall_image, field.x, field.y)
            else
                love.graphics.draw(path_image, field.x, field.y)
            end
        end
    end

    -- test
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", 5, 5, 5)
    love.graphics.circle("fill", 30, 30, 5)
    love.graphics.circle("fill", 100, 30, 5)
    love.graphics.circle("fill", 230, 70, 5)
    love.graphics.circle("fill", 230, 120, 5)
    love.graphics.circle("fill", 530, 440, 5)
    love.graphics.circle("fill", 530, 460, 5)
    love.graphics.circle("fill", 1000, 350, 5)
end