function(triggerId, name)
    debug("charCard 실행")
    local screen = getState(triggerId, "screen")
    if screen == "charList" then --캐릭터 조회화면
        if name == getPersonaName(triggerId) then
            name = "user"
        end
        local target = json.decode(getLoreBookContent(triggerId, name))
        stateToVar(triggerId, "target", target)
        local targetJuel = getState(triggerId, "juel")[name]
        stateToVar(triggerId, "targetJuel", targetJuel)
        setState(triggerId, "screen", "charInfo") --캐릭터 상세 정보 화면으로 이동

    elseif screen == "preTrain" then --조교 대상 화면
        sysFunction(triggerId, "preTrainSetting.sys", name)
        local targetJuel = getState(triggerId, "juel")[name]
        stateToVar(triggerId, "targetJuel", targetJuel)
        setState(triggerId, "screen", "train") --조교 화면으로 이동
    end
end