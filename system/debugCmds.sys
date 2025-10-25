function (triggerId)
    print("debugCmds 실행")
    local key, functionBody
    local funcs = getState(triggerId, "funcs") or {}

    --6974: 메인화면으로 복귀
    key = "6974"
    functionBody = [[
    function(triggerId)
    alertNormal(triggerId, "강제커맨드 발생. 메인화면으로 돌아갑니다.")
    setState(triggerId, "screen", "main")
    setChat(triggerId, getChatLength(triggerId)-1, "{{".."getvar::html".."}}")
    end]]
    funcs[key] = functionBody

    setState(triggerId, "funcs", funcs)
end