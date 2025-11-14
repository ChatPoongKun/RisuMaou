[shop/tools/hidden] function(triggerId)
    local itemCat = "tools"
    setChatVar(triggerId, "category", itemCat)
    sysFunction(triggerId, "itemCatSelect.sys", itemCat)
end!!

[shop/consumables/hidden] function(triggerId)
    local itemCat = "consumables"
    setChatVar(triggerId, "category", itemCat)
    sysFunction(triggerId, "itemCatSelect.sys", itemCat)
end!!

[shop/traps/hidden] function(triggerId)
    local itemCat = "traps"
    setChatVar(triggerId, "category", itemCat)
    sysFunction(triggerId, "itemCatSelect.sys", itemCat)
end!!

[shop/unlock/hidden] function(triggerId)
    local itemCat = "unlock"
    setChatVar(triggerId, "category", itemCat)
    sysFunction(triggerId, "itemCatSelect.sys", itemCat)
end!!

[shop/plus/hidden] function(triggerId)
    local itemName = getChatVar(triggerId, "itemName")
    local itemCount = getChatVar(triggerId, "itemQuantity")
    local itemPrice = tonumber(getChatVar(triggerId, "itemPrice"))
    local inventory = json.decode(getChatVar(triggerId, "inventory"))
    local gold = tonumber(getChatVar(triggerId, "gold"))
    local maxCount = math.min(9 - (inventory[itemName] or 0), math.floor(gold/itemPrice))

    itemCount = math.min(itemCount + 1, maxCount)
    setChatVar(triggerId, "itemQuantity", itemCount)
    setChatVar(triggerId, "itemTotalPrice", int(itemCount*itemPrice))
end!!

[shop/minus/hidden] function(triggerId)
    local itemCount = getChatVar(triggerId, "itemQuantity")
    local itemPrice = tonumber(getChatVar(triggerId, "itemPrice"))
    itemCount = math.max(itemCount - 1, 1)
    setChatVar(triggerId, "itemQuantity", itemCount)
    setChatVar(triggerId, "itemTotalPrice", int(itemCount*itemPrice))
end!!

[shop/purchase/hidden] function(triggerId)
    local itemName = getChatVar(triggerId, "itemName")
    local itemCount = getChatVar(triggerId, "itemQuantity")
    local itemTotalPrice = tonumber(getChatVar(triggerId, "itemTotalPrice"))
    local inventory = json.decode(getChatVar(triggerId, "inventory"))
    local gold = tonumber(getChatVar(triggerId, "gold"))
    local message = '<div class="purchased">'..itemName..' 구매완료!</div>'

    if itemTotalPrice > gold then
        alertNormal(triggerId, "골드가 부족합니다.")
        return
    end

    gold = gold - itemTotalPrice
    inventory[itemName] = tostring(inventory[itemName]+itemCount)
    setChatVar(triggerId, "gold", int(gold))
    setChatVar(triggerId, "inventory", json.encode(inventory))
    local itemCat = getChatVar(triggerId, "category")
    sysFunction(triggerId, "itemCatSelect.sys", itemCat)
    setChatVar(triggerId, "screenEffect", message)
end!!

[shop/심장석/hidden] function(triggerId)
    local itemName = "심장석"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/꿀단지웜/hidden] function(triggerId)
    local itemName = "꿀단지웜"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/애널웜/hidden] function(triggerId)
    local itemName = "애널웜"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/애널플러그/hidden] function(triggerId)
    local itemName = "애널플러그"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/애널비즈/hidden] function(triggerId)
    local itemName = "애널비즈"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/눈가리개/hidden] function(triggerId)
    local itemName = "눈가리개"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/볼개그/hidden] function(triggerId)
    local itemName = "볼개그"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/O링개그/hidden] function(triggerId)
    local itemName = "O링개그"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/점액달팽이/hidden] function(triggerId)
    local itemName = "점액달팽이"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/우유달팽이/hidden] function(triggerId)
    local itemName = "우유달팽이"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/채찍/hidden] function(triggerId)
    local itemName = "채찍"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/로프/hidden] function(triggerId)
    local itemName = "로프"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/관장기/hidden] function(triggerId)
    local itemName = "관장기"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/착유기/hidden] function(triggerId)
    local itemName = "착유기"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/개목걸이/hidden] function(triggerId)
    local itemName = "개목걸이"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/조합지식/hidden] function(triggerId)
    local itemName = "조합지식"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/음마지식/hidden] function(triggerId)
    local itemName = "음마지식"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/금단의지식/hidden] function(triggerId)
    local itemName = "금단의지식"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/콘돔/hidden] function(triggerId)
    local itemName = "콘돔"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/로션/hidden] function(triggerId)
    local itemName = "로션"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/이뇨제/hidden] function(triggerId)
    local itemName = "이뇨제"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/미약/hidden] function(triggerId)
    local itemName = "미약"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/수정구/hidden] function(triggerId)
    local itemName = "수정구"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/구충제/hidden] function(triggerId)
    local itemName = "구충제"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/영양제/hidden] function(triggerId)
    local itemName = "영양제"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/향/hidden] function(triggerId)
    local itemName = "향"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/강모제/hidden] function(triggerId)
    local itemName = "강모제"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!![shop/배란유발제/hidden] function(triggerId)
    local itemName = "배란유발제"
    sysFunction(triggerId, "itemSelect.sys", itemName)
end!!

[shop/199/돌아가기] function(triggerId)
    setChatVar(triggerId, "itemName", "")
    setChatVar(triggerId, "itemQuantity", 0)
    setChatVar(triggerId, "itemPrice", 0)
    setChatVar(triggerId, "itemTotalPrice", 0)
    setChatVar(triggerId, "itemDetail", "")
    setChatVar(triggerId, "category", "")
    setChatVar(triggerId, "category", "items")
    setState(triggerId, "screen", "main")
end!!