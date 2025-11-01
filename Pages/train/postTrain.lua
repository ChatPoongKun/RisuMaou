[postTrain/C민감도/hidden] function(triggerId)
    local abl = "C민감도"
    local lvUpConditions = {}

    table.insert(lvUpConditions,{
        ["C감각"] = {7,20,55,148,403,1097,2981,8103,22026,59874},
        ["C경험"] = {15,60,135,240,375,540,735,960,1215,1500}
    })
    table.insert(lvUpConditions,{
        ["C감각"] = {7,20,55,148,403,1097,2981,8103,22026,59874},
        ["발정"] = {7,20,55,148,403,1097,2981,8103,22026,59874}
    })
    sysFunction(triggerId, "ablLvUpConditionSelect.sys", abl, lvUpConditions)
end!!

[postTrain/B민감도/hidden] function(triggerId)
    local abl = "B민감도"
    local lvUpConditions = {}

    table.insert(lvUpConditions,{
        ["B감각"] = {7,20,55,148,403,1097,2981,8103,22026,59874},
        ["B경험"] = {15,60,135,240,375,540,735,960,1215,1500}
    })
    table.insert(lvUpConditions,{
        ["B감각"] = {7,20,55,148,403,1097,2981,8103,22026,59874},
        ["발정"] = {7,20,55,148,403,1097,2981,8103,22026,59874}
    })
    sysFunction(triggerId, "ablLvUpConditionSelect.sys", abl, lvUpConditions)
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

[postTrain/return/hidden] function(triggerId)
    setChatVar(triggerId, "selectedAbl", "none")
end!!

[postTrain/ablLvUp1/hidden] function(triggerId)
    debug("첫번째 조건으로 레벨업")
    --첫번째 배열은 렙업대상 어빌명. 배열 2번부터가 조건1번
    debug(json.encode(getState(triggerId, "selectedCondition")[1]))
    debug(json.encode(getState(triggerId, "selectedCondition")[2]))
    local abl = getState(triggerId, "selectedCondition")[1]
    local selectedCondition = getState(triggerId, "selectedCondition")[2]
    sysFunction(triggerId, "ablLvUp.sys", abl, selectedCondition)
end!!

[postTrain/ablLvUp2/hidden] function(triggerId)
    debug("두번째 조건으로 레벨업")
    --첫번째 배열은 렙업대상 어빌명. 배열 2번부터가 조건1번
    debug(json.encode(getState(triggerId, "selectedCondition")[1]))
    debug(json.encode(getState(triggerId, "selectedCondition")[3]))
    local abl = getState(triggerId, "selectedCondition")[1]
    local selectedCondition = getState(triggerId, "selectedCondition")[3]
    sysFunction(triggerId, "ablLvUp.sys", abl, selectedCondition)
end!!

[postTrain/ablLvUp3/hidden] function(triggerId)
    debug("세번째 조건으로 레벨업")
    --첫번째 배열은 렙업대상 어빌명. 배열 2번부터가 조건1번
    debug(json.encode(getState(triggerId, "selectedCondition")[1]))
    debug(json.encode(getState(triggerId, "selectedCondition")[4]))
    local abl = getState(triggerId, "selectedCondition")[1]
    local selectedCondition = getState(triggerId, "selectedCondition")[4]
    sysFunction(triggerId, "ablLvUp.sys", abl, selectedCondition)
end!!

[postTrain/ablLvUp4/hidden] function(triggerId)
    debug("네번째 조건으로 레벨업")
    --첫번째 배열은 렙업대상 어빌명. 배열 2번부터가 조건1번
    debug(json.encode(getState(triggerId, "selectedCondition")[1]))
    debug(json.encode(getState(triggerId, "selectedCondition")[5]))
    local abl = getState(triggerId, "selectedCondition")[1]
    local selectedCondition = getState(triggerId, "selectedCondition")[5]
    sysFunction(triggerId, "ablLvUp.sys", abl, selectedCondition)
end!!

[postTrain/ablLvUp5/hidden] function(triggerId)
    debug("다섯번째 조건으로 레벨업")
    --첫번째 배열은 렙업대상 어빌명. 배열 2번부터가 조건1번
    debug(json.encode(getState(triggerId, "selectedCondition")[1]))
    debug(json.encode(getState(triggerId, "selectedCondition")[6]))
    local abl = getState(triggerId, "selectedCondition")[1]
    local selectedCondition = getState(triggerId, "selectedCondition")[6]
    sysFunction(triggerId, "ablLvUp.sys", abl, selectedCondition)
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