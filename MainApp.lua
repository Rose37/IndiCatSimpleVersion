local userInterface = require('UserInterface')
local controll = require('KeyControll')
local tableField = require('TableControll')
local cristals = {'A', 'B', 'C', 'D', 'E', 'F'}
_G['matched'] = {}
_G['c'] = 0
_G['t'] = 360

function init()
    tableField.mix()
    userInterface.printTable(tableField)
end

function tick()
    os.execute("timeout 1s sleep 0")
    if _G['t'] <= 0 then
        _G['c'] = _G['c'] - 1
    else
        _G['t'] = _G['t'] - 1
    end
end

function dump()
    local matched = _G['matched']
    table.sort(matched, function(a, b) return a.y < b.y end)

    for i = 1, #matched do
        X, Y = matched[i].x, matched[i].y
        while true do
            tick()
            userInterface.printTable(tableField)
            if Y == 1 then
                tableField[Y][X] = cristals[math.random(#cristals)]
                break
            else
                temp = tableField[Y][X]
                tableField[Y][X] = tableField[Y - 1][X]
                tableField[Y - 1][X] = temp
                Y = Y - 1
            end
        end

        userInterface.printTable(tableField)
    end
    _G['matched'] = {}
end

init()
while true do
    if _G['t'] <= 0 then break end

    from, to, isExited = controll.readPoints()
    if isExited then break end

    tableField.move(from, to)
    tick()
    userInterface.printTable(tableField)

    isMatched = tableField.checkMatched(from, to)
    if isMatched then
        dump()
        tableField.checkPossibleMatches(dump)
        tableField.checkPossibleMove()
    end
    ::continue::
    userInterface.printTable(tableField)
end
userInterface.exitMessage()
