function(triggerId, name)
    debug("charCard 실행")
    local screen = getState(triggerId, "screen")
    if screen == "charList" then
        charToVar(triggerId, "target", name)
        setState(triggerId, "screen", "charInfo") --캐릭터 상세 정보 화면으로 이동

    elseif screen == "preTrain" then
        sysFunction(triggerId, "preTrainSetting")
        setState(triggerId, "screen", "train") --조교 화면으로 이동
    end
end