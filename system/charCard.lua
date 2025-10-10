function(triggerId, name)
    debug("charCard 실행")
    local screen = getState(triggerId, "screen")
    if screen == "charList" then
        charToVar(triggerId, "target", name)
        setState(triggerId, "screen", "charInfo") --캐릭터 상세 정보 화면으로 이동

    elseif screen == "preTrain" then
        --조교화면 변수 초기화
        setChatVar(triggerId, "애무계", 1)
        setChatVar(triggerId, "도구계", 0)
        setChatVar(triggerId, "V계", 0)
        setChatVar(triggerId, "A계", 0)
        setChatVar(triggerId, "봉사계", 0)
        setChatVar(triggerId, "하드계", 0)
        setChatVar(triggerId, "trainLog", "대상이 조교 준비중이다.")
        setChatVar(triggerId, "statRegax", "")
        setChatVar(triggerId, "orgasm_target", 0)
        setChatVar(triggerId, "orgasm_user", 0)

        --스탯 초기화
        local statDB =json.decode(getLoreBookContent(triggerId, "stat.db"))
        local stat = "{"
        local stat_s = {}
        for k, v in pairs(statDB) do
            stat = stat .. '"'..k..'":"0",'
            stat_s[k] = 0
        end
        stat = string.gsub(stat, ",$", "}")-- 마지막 쉼표 대신 중괄호 닫기
        setState(triggerId, "stat", stat_s) --초기화된 stat를 state에 저장
        setChatVar(triggerId, "stat", stat) --초기화된 stat를 챗변수에 저장
        charToVar(triggerId, "target", name) --대상 캐릭터 로어북을 챗변수에 저장
        setState(triggerId, "target", json.decode(getLoreBookContent(triggerId, name))) --대상 캐릭터 로어북 정보를 state에 저장
        --state와 chatVar를 둘다 갱신해줘야 cbs랑 lua가 다 잘 작동할 수 있음. 개귀찮..

        --abl에 따른 초기 stat 세팅
        --[[
        abl에 따른 초기 stat 세팅 작업할것!!!
        ]]

        setState(triggerId, "screen", "train") --조교 화면으로 이동
    end
end