require("lib.menu")
local height_ratio = 3 / 5
local width_ratio = 3 / 5

local x = 0
local y = love.graphics.getHeight() * height_ratio
local width = love.graphics.getWidth() * width_ratio
local height = love.graphics.getHeight() * (1 - height_ratio)
local shop_font = love.graphics.newFont(32)

-- podesavanja vezana za konkretan nivo

--local level_data = require("lib.level_data")
--local level_data = level_data

--local level_data = Level

-- podesavanja za ceo Shop
local shop_settings = {
    x = x,
    y = y,
    width = width,
    height = height,
    shop_font = shop_font
}

-- podesavanja za header Shop-a
local header_x = x
local header_y = y
local header_width = width
local header_height = height * 1 / 6

local header_settings = {
    x = header_x,
    y = header_y,
    width = header_width,
    height = header_height
}

-- podesavanja za deo Shop-a u kom se nalaze dugmici za postavljanje prepreka
local items_x = x
local items_y = y + height * 1 / 6
local items_width = width * 4 / 5
local items_height = height * 1 / 3
local items_color = {71/255, 74/255, 252/255}
local items_button_width = 48
local items_button_height = 48

local items_settings = {
    x = items_x,
    y = items_y,
    width = items_width,
    height = items_height,
    color = items_color,
    button_width = items_button_width,
    button_height = items_button_height
}

-- podesavanja za deo Shop-a u kom se prikazuje koliko igrac trenutno ima para
local currency_x = x + width * 4 / 5
local currency_y = y + height * 1 / 6
local currency_width = width * 1 / 5
local currency_height = height * 1 / 3
local currency_color = {57/255, 60/255, 227/255}

local currency_settings = {
    x = currency_x,
    y = currency_y,
    width = currency_width,
    height = currency_height,
    color = currency_color
}

-- podesavanja za deo Shop-a u kom se prikazuje slicica trenutno selektovanog item-a (odn. dugmeta)
local item_image_x = x
local item_image_y = y + height * 1 / 2
local item_image_width = width * 1 / 5
local item_image_height = height * 1 / 3
local item_image_color = {57/255, 60/255, 227/255}

local item_image_settings = {
    x = item_image_x,
    y = item_image_y,
    width = item_image_width,
    height = item_image_height,
    color = item_image_color
}

-- podesavanja za deo Shop-a u kom se prikazuje cena trenutno selektovanog item-a (odn. dugmeta)
local item_price_x = x
local item_price_y = y + height * 5 / 6
local item_price_width = width * 1 / 5
local item_price_height = height * 1 / 6
local item_price_color = {44/255, 50/255, 201/255}

local item_price_settings = {
    x = item_price_x,
    y = item_price_y,
    width = item_price_width,
    height = item_price_height,
    color = item_price_color
}

-- podesavanja za deo Shop-a u kom se prikazuje opis trenutno selektovanog item-a (odn. dugmeta)
local item_description_x = x + width * 1 / 5
local item_description_y = y + height * 1 / 2
local item_description_width = width * 4 / 5
local item_description_height = height * 1 / 2
local item_description_color = {50/255, 55/255, 227/255}

local item_description_settings = {
    x = item_description_x,
    y = item_description_y,
    width = item_description_width,
    height = item_description_height,
    color = item_description_color
}

return {
    level_data = level_data,
    shop_settings = shop_settings,
    header_settings = header_settings,
    items_settings = items_settings,
    currency_settings = currency_settings,
    item_image_settings = item_image_settings,
    item_price_settings = item_price_settings,
    item_description_settings = item_description_settings
}