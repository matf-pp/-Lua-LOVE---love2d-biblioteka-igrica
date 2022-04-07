local my_table = {}

local apple = {}
apple.calories = 2
apple.to_string = "apple"
table.insert(my_table, apple)

local bread = {}
bread.calories = 10
bread.to_string = "bread"
table.insert(my_table, bread)

local pear = {}
pear.calories = 3
pear.to_string = "pear"
table.insert(my_table, pear)

local chocolate = {}
chocolate.calories = 7
chocolate.to_string = "chocolate"
table.insert(my_table, chocolate)

table.sort(my_table, function (a, b)
    return a.calories < b.calories
end)

for _, value in pairs(my_table) do
    print(value.to_string)
end