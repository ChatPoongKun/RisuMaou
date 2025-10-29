[postTrain/C민감도/hidden] function(triggerId)
    local abl = "C민감도"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

    --요구흔적 및 경험 정의
    local rTrace = "C감각"
    local rExp = "C경험"
    local targetTrace = getState(triggerId, "trace")[target["이름"]]
    local traceExp = json.decode(getLoreBookContent(triggerId, "EXPtable.db"))[tostring(ablLv+1)]
    local expExp = (ablLv+1)*(ablLv+2)*5 --어빌렙의 등차수열 합 * 10

    if targetTrace[rTrace] > traceExp then
        if tonumber(target[rExp]) > expExp then
            targetTrace[rTrace] = targetTrace[rTrace]- traceExp
            target[abl] = target[abl]+1
            alertNormal(triggerId, abl.."레벨 상승! ("..ablLv.."->"..(ablLv+1)..")")
        else
            alertNormal(triggerId, "레벨업 불가: "..rExp.." 경험 "..(expExp - target[rExp]).."부족")
        end
    else
        alertNormal(triggerId, "레벨업 불가: "..rTrace.." 흔적 "..(traceExp - targetTrace[rTrace]).."부족")
    end
end!!

[postTrain/B민감도/hidden] function(triggerId)
    local abl = "B민감도"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/V민감도/hidden] function(triggerId)
    local abl = "V민감도"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/A민감도/hidden] function(triggerId)
    local abl = "A민감도"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/U민감도/hidden] function(triggerId)
    local abl = "U민감도"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/M민감도/hidden] function(triggerId)
    local abl = "M민감도"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/V확장/hidden] function(triggerId)
    local abl = "V확장"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/A확장/hidden] function(triggerId)
    local abl = "A확장"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/U확장/hidden] function(triggerId)
    local abl = "U확장"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/순응/hidden] function(triggerId)
    local abl = "순응"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/성욕/hidden] function(triggerId)
    local abl = "성욕"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/봉사기술/hidden] function(triggerId)
    local abl = "봉사기술"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/성교기술/hidden] function(triggerId)
    local abl = "성교기술"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/화술/hidden] function(triggerId)
    local abl = "화술"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

        --요구흔적 및 경험 정의
    local rTrace = "발정"
    local rExp = "조교회화경험"
    local targetTrace = getState(triggerId, "trace")[target["이름"]]
    local traceExp = json.decode(getLoreBookContent(triggerId, "EXPtable.db"))[tostring(ablLv+1)]
    local expExp = (ablLv+1)*(ablLv+2)*5 --어빌렙의 등차수열 합 * 10

    if targetTrace[rTrace] > traceExp then
        if tonumber(target[rExp]) > expExp then
            targetTrace[rTrace] = targetTrace[rTrace]- traceExp
            target[abl] = target[abl]+1
            alertNormal(triggerId, abl.."레벨 상승! ("..ablLv.."->"..(ablLv+1)..")")
        else
            alertNormal(triggerId, "레벨업 불가: "..rExp.." 경험 "..(expExp - target[rExp]).."부족")
        end
    else
        alertNormal(triggerId, "레벨업 불가: "..rTrace.." 흔적 "..(traceExp - targetTrace[rTrace]).."부족")
    end
end!!

[postTrain/노출벽/hidden] function(triggerId)
    local abl = "노출벽"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/마조끼/hidden] function(triggerId)
    local abl = "마조끼"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

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