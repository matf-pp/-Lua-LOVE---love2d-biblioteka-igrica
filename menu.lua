BUTTON_HEIGHT = 64


function new_button(text, fn)
    --funkcija koja pravi dugme kao povratnu vrednost daje table dugme
    return {
        text = text,
        fn = fn,
        
        --da se registruje klik na dugmetu samo jednom
        now = false,
        last = false
    }
end

Menu = {}
local font = nil

--da li raditi change the scene ili ostati sve na jednom ekranu?
function Menu:load()
    
    font = love.graphics.newFont(32)

    table.insert(Menu, new_button(
        "Start Game",
        function()  --anonimna funkcija
            print("Starting game")
        end))

    table.insert(Menu, new_button(
        "Load level",
        function()  --anonimna funkcija
            print("Pick a level")
        end))
            
    table.insert(Menu, new_button(
        "Exit",
        function()  --anonimna funkcija
            love.event.quit(0)
        end))
end

function Menu:update(dt)
    -- TODO
end

function Menu:draw()
    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()

    local button_width = ww*(1/3)
    local margin = 16

    --#Menu vraca broj dugmica u Menu = {}

    local total_height = (BUTTON_HEIGHT + margin) * #Menu
    local cursor_y = 0

    --indeks + dugme prolaz
    for i,button in ipairs(Menu) do
        --resetovanje stanja dugmeta
        button.last = button.now

        --x,y koordinate za dugmice
        local bx = (ww*0.9) - (button_width*0.9)
        local by = (wh*0.9) - (total_height*0.9) + cursor_y
        --boja dugmeta

        local color = {0.4,0.4,0.5,1.0}

        --pozicija kursora
        local mx,my = love.mouse.getPosition()

        --za hover preko dugmeta
        local hot = mx > bx and mx < bx + button_width and
                    my > by and my < by + BUTTON_HEIGHT
        
        if hot then 
            color  = {0.8,0.8,0.9,1.0}
        end

        --1 je leftclick
        --ako smo kliknuli dugme zovemo njegovu funkcionalnost
        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button.fn()
        end
        --unpack ugradjena funkcija
        --razbaca delove table-a u argumente zadata funkcije
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill",
            bx,
            by,
            button_width,
            BUTTON_HEIGHT
            
        
        )
        --boja teksta na dugmetu
        love.graphics.setColor(0,0,0,1)

        --treba nam racun velicine teksta u pikselima da bi ih stavili na sredinu dugmeta
        --ugradjena funkcija racuna velicinu texta za dati font u pikselima
        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)


        love.graphics.print(
            button.text,
            font,
            --local bx = (ww*0.9) - (button_width*0.9)
            --bx * textW * 0.5,
            --(ww * 0.9) - textW*0.5,
            --centriranje teksta? po x-osi
            (ww*0.9) - (button_width*0.9/2) - textW*0.5,
            by + textH *0.5
        )

        cursor_y = cursor_y + (BUTTON_HEIGHT + margin)
    end
end