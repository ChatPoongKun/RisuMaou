[main/100/조교 시작] function(triggerId)
    local screen = "preTrain"

    setState(triggerId, "screen", screen)
    local chars = json.decode(getChatVar(triggerId, "chars"))
    
    debug("대상: "..json.encode(chars))
    local charList = ""
    for index, value in ipairs(chars) do
        debug(index, value)
        local charInfo = json.decode(getLoreBookContent(triggerId, value))
        if charInfo["condition"] == "조교가능" then
            debug(json.encode(charInfo))
            local name = charInfo["이름"]
            local lv = charInfo["레벨"]
            local atk = charInfo["공격력"]
            local def = charInfo["방어력"]
            local crm = charInfo["카르마"]
            local hp = charInfo["체력"]
            local hpMax = charInfo["최대체력"]
            local hpRatio = 100*tonumber(hp)/tonumber(hpMax)
            local st = charInfo["기력"]
            local stMax = charInfo["최대기력"]
            local stRatio = 100*tonumber(st)/tonumber(stMax)
            local condition = charInfo["condition"]
            local title = charInfo["칭호"]
            if title == "" then
                title = " "
            end
            
            charList = charList .. "CHARACTER::"..index.."|"..name.."|"..lv.."|"..atk.."|"..def.."|"..crm.."|"..hp.."|"..hpMax.."|"..hpRatio.."|"..st.."|"..stMax.."|"..stRatio.."|"..condition.."|"..title.."::LIST"
        end
    end
    if charList == "" then
        charList = "조교 가능한 대상이 없습니다."
    end
    debug("charList: "..charList)
    setChatVar(triggerId, "charList", charList)

end!!

[main/101/캐릭터 정보] function(triggerId)
    local screen = "charList"
    setState(triggerId, "screen", screen)
    local chars = json.decode(getChatVar(triggerId, "chars"))
    
    debug("대상: "..json.encode(chars))
    local charList = ""
    for index, value in ipairs(chars) do
        debug(index, value)
        local charInfo = json.decode(getLoreBookContent(triggerId, value))
        debug(json.encode(charInfo))
        local name = charInfo["이름"]
        local lv = charInfo["레벨"]
        local atk = charInfo["공격력"]
        local def = charInfo["방어력"]
        local crm = charInfo["카르마"]
        local hp = charInfo["체력"]
        local hpMax = charInfo["최대체력"]
        local hpRatio = 100*tonumber(hp)/tonumber(hpMax)
        local st = charInfo["기력"]
        local stMax = charInfo["최대기력"]
        local stRatio = 100*tonumber(st)/tonumber(stMax)
        local condition = charInfo["condition"]
        local title = charInfo["칭호"]
        print(charInfo["칭호"])
        if title == "" then
            title = " "
        end

        charList = charList .. "CHARACTER::"..index.."|"..name.."|"..lv.."|"..atk.."|"..def.."|"..crm.."|"..hp.."|"..hpMax.."|"..hpRatio.."|"..st.."|"..stMax.."|"..stRatio.."|"..condition.."|"..title.."::LIST"
    end
    debug("charList: "..charList)
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

[main/106/격퇴] function(triggerId)
    local screen = "격퇴"
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
    --하루가 지나갈때의 처리는 복잡한 처리가 필요하므로 유지관리를 위해 별도처리
    sysFunction(triggerId, "turnEnd.sys")
end!!

[main/hr/ ] function end!!

[main/777/설정] function(triggerId)
    local screen = "config"
    setState(triggerId, "screen", screen)
end!!

[main/999/마계사전] function(triggerId)
    local screen = "마계사전"
    alertNormal(triggerId, screen.." 미구현")
end!!