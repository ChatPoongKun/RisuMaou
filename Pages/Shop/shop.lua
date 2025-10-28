[shop/tools/hidden] function(triggerId)
    local itemList = json.decode(getLoreBookContent(triggerId, "items.db"))["조교도구"]
    local contents = ""

    for k,v in pairs(itemList) do
        local price = int(v[1])
        contents = contents .. "<div class='shop-item'><div class='item-image'><img src='{{raw::"..k..".png}}'></div><div class='item-info'><span class='item-name'>"..k.."</span><span class='item-price'>"..price.." Gold</span></div></div>"
    end
    setChatVar(triggerId, "tools", contents)
end!!

[shop/consumables/hidden] function(triggerId)
    local itemList = json.decode(getLoreBookContent(triggerId, "items.db"))["소모품"]
    local contents = ""

    for k,v in pairs(itemList) do
        local price = int(v[1])
        contents = contents .. "<div class='shop-item'><div class='item-image'><img src='{{raw::"..k..".png}}'></div><div class='item-info'><span class='item-name'>"..k.."</span><span class='item-price'>"..price.." Gold</span></div></div>"
    end
    setChatVar(triggerId, "tools", contents)
end!!

[shop/traps/hidden] function(triggerId)
    local itemList = json.decode(getLoreBookContent(triggerId, "items.db"))["함정"]
    local contents = ""

    for k,v in pairs(itemList) do
        local price = int(v[1])
        contents = contents .. "<div class='shop-item'><div class='item-image'><img src='{{raw::"..k..".png}}'></div><div class='item-info'><span class='item-name'>"..k.."</span><span class='item-price'>"..price.." Gold</span></div></div>"
    end
    setChatVar(triggerId, "tools", contents)
end!!

[shop/199/돌아가기] function(triggerId)
    setState(triggerId, "screen", "main")
end!!