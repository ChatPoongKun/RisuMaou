function (triggerId)
    --초기 변수 설정
    local initVars = {
        gold = 10000,
        day = 1,
        ampm = 0, --0은 오전 1은 오후
        chars = '["user","마오"]', --리수의 배열 변수 형식에 맞춤
        DEBUG = DEBUG
    }
    for key, value in pairs(initVars) do
        setChatVar(triggerId, key, value)
    end

    --user 및 고유캐릭터 정보를 로컬 로어북에 저장
    for _, v in ipairs(json.decode(initVars.chars)) do --리수형식의 배열을 다시 테이블로 전환
        local content = getLoreBookContent(triggerId, v..".init")
        local option = {
        alwaysActive = false,
        insertOrder = 100,
        key = "",
        secondKey = "",
        regex = false
        }
        upsertLocalLoreBook(triggerId, v, content, option)
    end
end