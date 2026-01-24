[cheat/0/캐릭터 생성] function(triggerId)
    sysFunction(triggerId, "newChar.sys")
end!!

[cheat/1/Spirit 설정] function(triggerId)
    local currentSpirit = getChatVar(triggerId, "spirit")
    local input = alertInput(triggerId, "Spirit 값을 입력하세요.\n(현재: "..currentSpirit..")\n숫자만 입력 가능합니다."):await()
    local newSpirit = tonumber(input)
    
    if newSpirit == nil then
        alertError(triggerId, "올바른 숫자를 입력해주세요.")
        return
    end
    
    if newSpirit < 0 then
        alertError(triggerId, "Spirit은 0 이상이어야 합니다.")
        return
    end
    
    setChatVar(triggerId, "spirit", intForm(newSpirit))
    alertNormal(triggerId, "Spirit이 "..intForm(newSpirit).."로 설정되었습니다.")
end!!

[cheat/199/돌아가기] function(triggerId)
    screenChange(triggerId, getState(triggerId, "oldScreen"))
end!!