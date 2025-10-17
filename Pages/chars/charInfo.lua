[charInfo/100/능력 레벨업] function(triggerId)
    alertNormal(triggerId, "미구현")
end!!

[charInfo/199/돌아가기] function(triggerId)
    setChatVar(triggerId, "target", "") --조회대상 초기화
    setState(triggerId, "screen", "charList")
end!!