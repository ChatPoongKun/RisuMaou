[postTrain/C감각/hidden] function(triggerId)
    local abl = "C감각"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

    --요구주얼 및 경험 정의
    local rJuel = "C쾌락"
    local rExp = "C경험"
    local targetJuel = getState(triggerId, "juel")[target["이름"]]
    local juelExp = json.decode(getLoreBookContent(triggerId, "EXPtable.db"))[tostring(ablLv+1)]
    local expExp = (ablLv+1)*(ablLv+2)*5 --어빌렙의 등차수열 합 * 10

    if targetJuel[rJuel] > juelExp then
        if target[rExp] > expExp then
            targetJuel[rJuel] = targetJuel[rJuel]- juelExp
            target[abl] = target[abl]+1
            alertNormal(triggerId, abl.."레벨 상승! ("..ablLv.."->"..(ablLv+1)..")")
        else
            alertNormal(triggerId, "레벨업 불가: "..rExp.." 경험 "..(expExp - target[rExp]).."부족")
        end
    else
        alertNormal(triggerId, "레벨업 불가: "..rJuel.." 주얼 "..(juelExp - targetJuel[rJuel]).."부족")
    end

end!!

[postTrain/B감각/hidden] function(triggerId)
    local abl = "B감각"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/V감각/hidden] function(triggerId)
    local abl = "V감각"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/A감각/hidden] function(triggerId)
    local abl = "A감각"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/U감각/hidden] function(triggerId)
    local abl = "U감각"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/M감각/hidden] function(triggerId)
    local abl = "M감각"
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

[postTrain/순종/hidden] function(triggerId)
    local abl = "순종"
    local target = getState(triggerId, "target")
    local ablLv = target[abl]

end!!

[postTrain/욕망/hidden] function(triggerId)
    local abl = "욕망"
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
    setChatVar(triggerId, "postTrain", "") --리스트 변수 초기화
    setState(triggerId, "screen", "main")
end!!