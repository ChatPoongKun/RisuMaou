[postTrain/C민감도/hidden] function(triggerId)
    local abl = "C민감도"
    local rTrace = "C감각"
    local rExp = "C경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/B민감도/hidden] function(triggerId)
    local abl = "B민감도"
    local rTrace = "B감각"
    local rExp = "B경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/V민감도/hidden] function(triggerId)
    local abl = "V민감도"
    local rTrace = "V감각"
    local rExp = "V경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/A민감도/hidden] function(triggerId)
    local abl = "A민감도"
    local rTrace = "A감각"
    local rExp = "A경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/U민감도/hidden] function(triggerId)
    local abl = "U민감도"
    local rTrace = "U감각"
    local rExp = "U경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/M민감도/hidden] function(triggerId)
    local abl = "M민감도"
    local rTrace = "복종"
    local rExp = "펠라경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/V확장/hidden] function(triggerId)
    local abl = "V확장"
    local rTrace = "발정"
    local rExp = "V확장경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/A확장/hidden] function(triggerId)
    local abl = "A확장"
    local rTrace = "발정"
    local rExp = "A확장경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/U확장/hidden] function(triggerId)
    local abl = "U확장"
    local rTrace = "굴욕"
    local rExp = "요도경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/순응/hidden] function(triggerId)
    local abl = "순응"
    local rTrace = "순종"
    local rExp = "애정경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/성욕/hidden] function(triggerId)
    local abl = "성욕"
    local rTrace = "발정"
    local rExp = "절정경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/봉사기술/hidden] function(triggerId)
    local abl = "봉사기술"
    local rTrace = "기술"
    local rExp = "봉사경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/성교기술/hidden] function(triggerId)
    local abl = "성교기술"
    local rTrace = "기술"
    local rExp = "성교경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/화술/hidden] function(triggerId)
    local abl = "화술"
    local rTrace = "발정"
    local rExp = "조교회화경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/노출벽/hidden] function(triggerId)
    local abl = "노출벽"
    local rTrace = "굴욕"
    local rExp = "비접촉절정"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/마조끼/hidden] function(triggerId)
    local abl = "마조끼"
    local rTrace = "상처"
    local rExp = "피학경험"
    sysFunction(triggerId, "ablLvUp.sys", abl, rTrace, rExp)
end!!

[postTrain/199/조교종료] function(triggerId)
    --변수 초기화
    setState(triggerId, "target", "")
    setChatVar(triggerId, "target", "")
    setState(triggerId, "stat", "")
    setChatVar(triggerId, "stat", "")
    setChatVar(triggerId, "targetTrace", "")
    
    sysFunction(triggerId, "turnEnd.sys")
    setState(triggerId, "screen", "main")
end!!