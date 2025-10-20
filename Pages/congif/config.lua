

[config/hr/<h2 style="text-align:left;margin-top:1rem;">▋ 조교</h2>]function end!!

[config/100/난이도 | {{#when::{{getvar::difficulty}}::is::쉬움}}쉬움{{/when}}{{#when::{{getvar::difficulty}}::is::보통}}보통{{/when}}{{#when::{{getvar::difficulty}}::is::어려움}}어려움{{/when}}] function(triggerId)
    local difficulty = getChatVar(triggerId, "difficulty")

    if difficulty == "쉬움" then
        print("쉬움->보통")
        MAXROLL = 30
        setChatVar(triggerId, "difficulty", "보통")
    elseif difficulty == "보통" then
        print("보통->어려움")
        MAXROLL = 40
        setChatVar(triggerId, "difficulty", "어려움")
    else
        print("어려움->쉬움")
        MAXROLL = 25
        setChatVar(triggerId, "difficulty", "쉬움")
    end
end!!

[config/101/사망방지 | {{#when::{{getvar::allowDeath}}::is::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    local allowDeath = getChatVar(triggerId, "allowDeath")

    allowDeath = math.abs(allowDeath-1)
    setChatVar(triggerId, "allowDeath", allowDeath)
end!!


[config/hr/<h2 style="text-align:left;margin-top:1rem;">▋ 디버깅</h2>]function end!!

[config/999/디버깅 | {{#when::{{getvar::debug}}::is::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    DEBUG = math.abs(DEBUG-1)
    setChatVar(triggerId, "debug", DEBUG)
end!!

[config/hr/ ]function end!!

[config/199/돌아가기] function(triggerId)
    setState(triggerId, "screen", "main")
end!!