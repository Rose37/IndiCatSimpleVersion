local controll = {}
local TABLE_SIZE = 10
local directionMap = {
    ['u'] = 'Up',
    ['l'] = 'Left',
    ['r'] = 'Right',
    ['d'] = 'Down'
}

local function isInvalid(commands)
    return (#commands ~= 4 or commands[1] ~= 'm' or tonumber(commands[2]) < 0 or
               tonumber(commands[2]) > 9 or tonumber(commands[3]) < 0 or
               tonumber(commands[3]) > 9 or
               (string.match("urld", commands[4]) == nil))
end

local function split(s)
    delimiter = ' '
    result = {};
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match);
    end
    return result;
end

local function getToCoordanate(from, toDirecion)
    result = {x = from.x, y = from.y}
    if toDirecion == 'u' and from.y > 1 then
        result.y = from.y - 1
    elseif toDirecion == 'l' and from.x > 1 then
        result.x = from.x - 1
    elseif toDirecion == 'r' and from.x < TABLE_SIZE then
        result.x = from.x + 1
    elseif toDirecion == 'd' and from.y < TABLE_SIZE then
        result.y = from.y + 1
    end
    return result
end

function controll.readPoints()
    commandLine = io.read()
    if commandLine == 'q' or commandLine == 'Q' then return nil, nil, true end
    commands = split(commandLine)
    if isInvalid(commands) then return nil, nil, false end
    X, Y = commands[2] + 1, commands[3] + 1
    from = {x = X, y = Y}
    to = getToCoordanate(from, commands[4])
    return from, to, false
end

return controll
