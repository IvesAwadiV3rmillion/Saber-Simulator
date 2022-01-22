function MakeChangeLogs(...)
    local changeLogs = ""
    for i,v in pairs(...) do
        changeLogs = changeLogs .. '[*] ' .. v .. '\n'
    end
    return changeLogs
end

-- Examples
print(MakeChangeLogs({
    "Added blah, blah, blah",
    "Updated script!",
    "Roblox scucks"
}))
