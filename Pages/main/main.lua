[main/100/조교 시작] function(triggerId)
    local screen = "train"
    setChatVar(triggerId, "애무계", 1)
    setChatVar(triggerId, "도구계", 0)
    setChatVar(triggerId, "V계", 0)
    setChatVar(triggerId, "A계", 0)
    setChatVar(triggerId, "봉사계", 0)
    setChatVar(triggerId, "하드계", 0)
    setState(triggerId, "screen", screen)
    setChatVar(triggerId, "trainLog", "대상이 조교 준비중이다.")

end!!

[main/101/캐릭터 정보] function(triggerId)
    local screen = "charList"
    setState(triggerId, "screen", screen)
    local chars = json.decode(getChatVar(triggerId, "chars"))
    local charList = ""

    for index, value in ipairs(chars) do
        local charInfo = json.decode(getLoreBookContent(triggerId, value))
        local name = charInfo["base"]["이름"]
        local lv = charInfo["base"]["레벨"]
        local atk = charInfo["base"]["공격력"]
        local def = charInfo["base"]["방어력"]
        local crm = charInfo["base"]["카르마"]
        local hp = charInfo["base"]["체력"]/1000
        local hpMax = charInfo["base"]["최대 체력"]/1000
        local hpRatio = 100*hp/hpMax
        local st = charInfo["base"]["기력"]/1000
        local stMax = charInfo["base"]["최대 기력"]/1000
        local stRatio = 100*st/stMax

        charList = charList .. "CHARACTER::"..index.."|"..name.."|"..lv.."|"..atk.."|"..def.."|"..crm.."|"..hp.."|"..hpMax.."|"..hpRatio.."|"..st.."|"..stMax.."|"..stRatio.."::CARD"
        debug(charList)
    end
    setChatVar(triggerId, "charList", charList)

end!!

[main/102/포로 처분] function(triggerId)
    local screen = "포로 처분"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/103/노예 매각] function(triggerId)
    local screen = "노예 매각"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/104/상점] function(triggerId)
    local screen = "상점"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/105/장비 관리] function(triggerId)
    local screen = "장비 관리"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/106/영격] function(triggerId)
    local screen = "영격"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/107/침공] function(triggerId)
    local screen = "침공"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/108/실험실] function(triggerId)
    local screen = "실험실"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/109/시설 관리] function(triggerId)
    local screen = "시설 관리"
    alertNormal(triggerId, screen.." 미구현")
end!!

[main/199/휴식] function(triggerId)
    local screen = "휴식"
    alertNormal(triggerId, "쉽니다 쿨쿨..")
end!!

[main/777/설정] function(triggerId)
    local screen = "config"
    setState(triggerId, "screen", screen)
end!!

[main/999/마계사전] function(triggerId)
    local screen = "마계사전"
    alertNormal(triggerId, screen.." 미구현")
end!!