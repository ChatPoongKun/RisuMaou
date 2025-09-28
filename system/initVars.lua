function (triggerId)
    local initVars = {
        gold = 10000,
        day = 1,
        ampm = 0, --0은 오전 1은 오후
        chars = '["user","마오"]',
        DEBUG = DEBUG,
        screen = "main"
    }
    for key, value in pairs(initVars) do
        setChatVar(triggerId, key, value)
    end
end