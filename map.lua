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
    self.grid = {}
    for i = 1, self.m, 1 do
        self.grid[i] = {}
        for j = 1, self.n, 1 do
            self.grid[i][j] = {}
            self.grid[i][j].row = i
            self.grid[i][j].column = j
            self.grid[i][j].adjacencies = {}

            self.grid[i][j].x = self.grid_x + (self.grid[i][j].column - 1) * self.field_side
            self.grid[i][j].y = self.grid_y + (self.grid[i][j].row - 1) * self.field_side
        end
    end

    -- Kroz ovu petlju se postavljaju grane grafa
    for i = 1, self.m, 1 do
        for j = 1, self.n, 1 do
            local index = 0
            if self.grid[i-1] ~= nil then
                index = index + 1
                self.grid[i][j]["adjacencies"][index] = self.grid[i-1][j]
            end
            if self.grid[i+1] ~= nil then
                index = index + 1
                self.grid[i][j]["adjacencies"][index] = self.grid[i+1][j]
            end
            if self.grid[i][j-1] ~= nil then
                index = index + 1
                self.grid[i][j]["adjacencies"][index] = self.grid[i][j-1]
            end
            if self.grid[i][j+1] ~= nil then
                index = index + 1
                self.grid[i][j]["adjacencies"][index] = self.grid[i][j+1]
            end
        end
    end
end

function Map:update(dt)
    -- TODO
end

function Map:draw()
    -- Pozadina cele mape
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- Pozadina grid-a
    love.graphics.setColor(36/255, 64/255, 201/255)
    love.graphics.rectangle("fill", self.grid_x, self.grid_y, self.grid_width, self.grid_height)

    -- Crtanje polja grid-a
    love.graphics.setColor(224/255, 235/255, 38/255)
    for _, row in pairs(self.grid) do
        for _, field in pairs(row) do
            love.graphics.rectangle("line", field.x, field.y, self.field_side, self.field_side)
        end
    end
end