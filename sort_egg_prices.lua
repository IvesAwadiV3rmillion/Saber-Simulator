    -- Copied from Saber Simulator Devs Modules LOL!
    ShorterNumber = function(p1)
        if p1 < 0 then
            p1 = 0
        end
        if p1 >= 1E+300 then
            return "\226\136\158" -- synapse decompiler is ass but ok
        end;
        local v1 = { { 1, "" }, { 1000, "K" }, { 1000000, "M" }, { 1000000000, "B" }, { 1000000000000, "t" }, { 1000000000000000, "q" }, { 1E+18, "Q" }, { 1E+21, "s" }, { 1E+24, "S" }, { 1E+27, "o" }, { 1E+30, "n" }, { 1E+33, "d" }, { 1E+36, "U" }, { 1E+39, "D" }, { 1E+42, "T" }, { 1E+45, "Qt" }, { 1E+48, "Qd" }, { 1E+51, "Sd" }, { 1E+54, "St" }, { 1E+57, "O" }, { 1E+60, "N" }, { 1E+63, "v" }, { 1E+66, "c" } }
        for v2, v3 in ipairs(v1) do
            if v3[1] <= p1 + 1 then
                v1.use = v2
            end
        end
        local v4 = string.format("%.3f", p1 / v1[v1.use][1])
        if tonumber(v4) >= 1000 and v1.use < #v1 then
            v1.use = v1.use + 1
            v4 = string.format("%.3f", tonumber(v4) / 1000)
        end
        local v5 = false
        if string.sub(v4, string.len(v4)) == "0" or string.sub(v4, string.len(v4)) == "." then
            while true do
                if string.sub(v4, string.len(v4)) == "." then
                    v5 = true
                end
                v4 = string.sub(v4, 1, string.len(v4) - 1)
                if v5 then
                    break
                end
                if string.sub(v4, string.len(v4)) ~= "0" and string.sub(v4, string.len(v4)) ~= "." then
                    break
                end
            end
        end
        return v4 .. v1[v1.use][2]
    end
    -- Terrible way of sorting egg prices (cuz saber sim devs are cringe...)
    coroutine.wrap(function()
    for i,v in ipairs(game:GetService("ReplicatedStorage").Eggs:GetChildren()) do
        if v:IsA("Folder") then
            for i,x in ipairs(v:GetChildren()) do
                if x:IsA("NumberValue") and x.Name == "Price" then
                    table.insert(tbl,{eggname = v.Name, price = x.Value})
                    --table.insert(tbl, x.Value) -- yes used it for testing but it works!
                end
            end
        end
    end
    end)
    -- bruh
    table.sort(tbl, function(a,b) -- sort currency and shit (Could be done better I think? didn't see any modules that lists all the egg prices (formated correctly)
        return a.price < b.price
    end)
    -- Just posting it here on github incase I need it for something later on.
    for i,v in ipairs(tbl) do
        print(v.eggname, v.price)
        --print(ShorterNumber(v)) -- pretty much outputs the egg prices (sorted correctly atleast)
    end
