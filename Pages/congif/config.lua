[config/play/hidden] function(triggerId)
    local configCat = "play"
    setChatVar(triggerId, "category", configCat)
end!!

[config/system/hidden] function(triggerId)
    local configCat = "system"
    setChatVar(triggerId, "category", configCat)
end!!

[config/difficulty/hidden] function(triggerId)
    local difficulty = getChatVar(triggerId, "difficulty")

    if difficulty == "쉬움" then
        MAXROLL = 30
        setChatVar(triggerId, "difficulty", "보통")
    elseif difficulty == "보통" then
        MAXROLL = 20
        setChatVar(triggerId, "difficulty", "어려움")
    else
        MAXROLL = 40
        setChatVar(triggerId, "difficulty", "쉬움")
    end
end!!

[config/blockDeath/hidden] function(triggerId)
    local blockDeath = getChatVar(triggerId, "blockDeath")

    blockDeath = math.abs(blockDeath-1)
    setChatVar(triggerId, "blockDeath", blockDeath)
end!!

[config/history/hidden] function(triggerId)
    local history = getChatVar(triggerId, "history")
    history = math.abs(history-1)
    setChatVar(triggerId, "history", history)
end!!

[config/debug/hidden] function(triggerId)
    local debug = getChatVar(triggerId, "debug")
    debug = math.abs(debug-1)
    setChatVar(triggerId, "debug", debug)
end!!



[config/199/설정완료] function(triggerId)
    local screen = "main"
    setChatVar(triggerId, "category", "items")
    setState(triggerId, "category", "")
    setState(triggerId, "screen", screen)
end!!
