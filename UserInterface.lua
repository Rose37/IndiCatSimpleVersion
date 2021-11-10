local interface = {}
local TABLE_SIZE = 10

local function clearScreen() os.execute("clear") end

function interface.printTable(tableField)
    clearScreen()
    print("")
    print("   0 1 2 3 4 5 6 7 8 9")
    print("   -------------------")
    for i = 1, TABLE_SIZE do
        row = i - 1 .. "| " .. table.concat(tableField[i], " ") .. " |" .. i - 1
        if i == 1 then
            row = row .. "  Score: " .. _G['c']
        elseif i == 2 then
            row = row .. "  Tick: " .. _G['t']
        end
        print(row)
    end
    print("   -------------------")
    print("   0 1 2 3 4 5 6 7 8 9")
end

function interface.exitMessage() print("Exit") end

function interface.startScreen() clearScreen() end

return interface
