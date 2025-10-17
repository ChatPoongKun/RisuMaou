function(triggerId, name)
    debug("charCard 실행")
    local screen = getState(triggerId, "screen")
    if screen == "charList" then
        if name == getPersonaName(triggerId) then
            name = "user"
        end
        local target = json.decode(getLoreBookContent(triggerId, name))
        stateToVar(triggerId, "target", target)
        setState(triggerId, "screen", "charInfo") --캐릭터 상세 정보 화면으로 이동

    elseif screen == "preTrain" then
        sysFunction(triggerId, "preTrainSetting.sys", name)
        setState(triggerId, "screen", "train") --조교 화면으로 이동
    end
end