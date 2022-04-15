local level_data = require("levels.test_level_04")
local map_data = require("lib.map_config")

Map = {}

function Map:load()
    -- koordinate gornjeg levog ugla mape
    self.x, self.y = map_data.x, map_data.y
    -- sirina i visina mape
    self.width, self.height = map_data.width, map_data.height
    -- broj vrsta i kolona u grid-u
    self.m, self.n = map_data.num_rows, map_data.num_columns
    -- koordinate gornjeg levog ugla grid-a
    self.grid_x, self.grid_y = map_data.grid_x, map_data.grid_y
    -- sirina i visina grid-a
    self.grid_width, self.grid_height = map_data.grid_width, map_data.grid_height
    -- duzina stranice polja
    self.field_side = map_data.field_side
    -- pocetak i kraj
    self.start_field, self.end_field = {}, {}

    -- grid - grafovska reprezentacija polja na mapi
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
            
            field.damage = 0

            -- podaci o karakteristikama polja, odn. njegovom tipu
            field.has_wall = false
            field.is_start = false
            field.is_end = false
            field.has_spikes = false

            if level_data.data[k] == level_data.wall_id then
                field.has_wall = true
            end

            if level_data.data[k] == level_data.start_id then
                field.is_start = true
                self.start_field = field
            end

            if level_data.data[k] == level_data.end_id then
                field.is_end = true
                self.end_field = field
            end

            if level_data.data[k] == level_data.spikes_id then
                field.has_spikes = true
                field.damage = field.damage + 1
            end

            k = k + 1

            -- grafika polja
            field.x = self.grid_x + (field.column - 1) * self.field_side
            field.y = self.grid_y + (field.row - 1) * self.field_side
            field.image = level_data.images.path_image
            field.quad = love.graphics.newQuad(0, 0, 48, 48, 48, 48)
            field.scale_factor = level_data.image_scale_factor
            field.clock = 0

            function field:update(dt)
                self.clock = self.clock + dt
                self:update_image(dt)
            end

            function field:update_image(dt)
                if self.is_start then
                    self.image = level_data.images.start_image
                elseif self.is_end then
                    self.image = level_data.images.end_image
                elseif self.has_wall then
                    self.image = level_data.images.wall_image
                elseif self.has_spikes then
                    if self.clock >= 0 and self.clock < 0.05 then
                        self.image = level_data.images.spikes_image_0
                    elseif self.clock >= 0.05 and self.clock < 0.1 then
                        self.image = level_data.images.spikes_image_1
                    elseif self.clock >= 0.1 and self.clock < 0.15 then
                        self.image = level_data.images.spikes_image_2
                    elseif self.clock >= 0.15 and self.clock < 1.5 then
                        self.image = level_data.images.spikes_image_3
                    elseif self.clock >= 1.5 and self.clock < 1.6 then
                        self.image = level_data.images.spikes_image_2
                    elseif self.clock >= 1.6 and self.clock < 1.7 then
                        self.image = level_data.images.spikes_image_1
                    elseif self.clock >= 1.7 and self.clock < 1.9 then
                        self.image = level_data.images.spikes_image_0
                    else
                        self.clock = 0
                    end
                else
                    self.image = level_data.images.path_image
                end
            end

            function field:draw()
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(self.image, self.quad, self.x, self.y, 0, self.scale_factor, self.scale_factor)
            end
        end
    end

    -- postavljanje grana u grafu
    self:set_branches()
end

function Map:update(dt)
    for _, row in pairs(self.grid) do
        for _, field in pairs(row) do
            field:update(dt)
        end
    end
end

function Map:draw()
    -- crtanje pozadine mape
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- crtanje grid-a
    for _, row in pairs(self.grid) do
        for _, field in pairs(row) do
            field:draw()
        end
    end
end

--[[
    Funkcija postavlja grane grafa.
]]
function Map:set_branches()
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
        ako je u pitanju path, postavlja wall,
        ako je u pitanju wall, start ili end, ne radi nista,
        itd.
    Povratna vrednost je tipa bool i predstavlja uspeh pri postavljanju zida:
        ako je uspelo, vraca true,
        u suprotnom, false
]]
function Map:add_wall(x, y)
    local dx = x - self.grid_x
    local dy = y - self.grid_y
    local i = math.floor(dy / self.field_side) + 1
    local j = math.floor(dx / self.field_side) + 1

    if i <= 0 or i > self.m or j <= 0 or j > self.n then
        return false
    end

    local field = self.grid[i][j]

    if field.is_start or field.is_end or field.has_wall or field.has_spikes then
        return false
    end

    self.grid[i][j].has_wall = true
    print("Uspesno dodat zid na koordinatama ( "..dx.." , "..dy.." )")

    return true
end

--[[
    Funkcija vraca table u kome se nalaze cvorovi na putanji od pocetnog do krajnjeg polja na mapi,
        odn. prazan table ako putanja ne postoji.
]]
function Map:find_path()
    local paths = self:all_paths(self.start_field, self.end_field)
    table.sort(
        paths,
        function (a, b)
            if a.life_cost > b.life_cost then
                return false
            else
                return a.length < b.length
            end
        end
    )

    if next(paths) == nil then
        return {}
    end
    
    local result_reverse = paths[1].nodes
    local result = {}

    for i = #result_reverse, 1, -1 do
        table.insert(result, result_reverse[i])
    end

    return result
end

function Map:find_path_2(start, finish)
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
    local current = finish
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

    local result_reverse = {}
    for i = #result, 1, -1 do
        table.insert(result_reverse, result[i])
    end
    return result_reverse
end

function Map:all_paths(start, finish)
    if start == finish then
        local result = {}
        
        local path = {}
        path.nodes = {}
        table.insert(path.nodes, finish)
        path.length = 1
        path.life_cost = finish.damage

        table.insert(result, path)
        return result
    end

    start.visited = true
    local paths = {}
    
    for _, neighbor in pairs(start.neighbors) do
        if neighbor.visited == false and neighbor.has_wall == false then
            local neighbor_paths = self:all_paths(neighbor, finish)
            for _, neighbor_path in pairs(neighbor_paths) do
                table.insert(neighbor_path.nodes, start)
                neighbor_path.length = neighbor_path.length + 1
                neighbor_path.life_cost = neighbor_path.life_cost + start.damage
                table.insert(paths, neighbor_path)
            end
        end
    end

    start.visited = false
    return paths
end