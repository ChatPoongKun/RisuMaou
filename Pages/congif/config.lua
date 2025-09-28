[config/999/디버깅| {{#when::DEBUG::vis::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    DEBUG = math.abs(DEBUG-1)
    setChatVar(triggerId, "DEBUG", DEBUG)
end!!

[config/199/돌아가기] function(triggerId)
    setState(triggerId, "screen", "main")
end!!