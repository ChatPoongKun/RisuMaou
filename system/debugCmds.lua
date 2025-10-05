function (triggerId)
    key = ""
    functionBody = ""
    
    --6974: 메인화면으로 복귀
    key = 6974
    functionBody = [[
    function(triggerId)
    alertNormal(triggerId, "강제커맨드 발생. 메인화면으로 돌아갑니다.")
    setState(triggerId, "screen", "main")
    end]]
    setState(triggerId, key, functionBody)
end