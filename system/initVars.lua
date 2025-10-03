function (triggerId)
    --초기 변수 설정
    local initVars = {
        gold = "10,000",
        day = 1,
        ampm = 0, --0은 오전 1은 오후
        chars = '["user","마오"]', --리수배열 스타일에 맞게 저장
        DEBUG = DEBUG,
        expLv = getLoreBookContent(triggerId, "expLv.db")
    }
    
    for key, value in pairs(initVars) do
        setChatVar(triggerId, key, value)
    end
    --user 및 고유캐릭터 정보를 로컬 로어북에 저장
    for _, v in ipairs(json.decode(initVars.chars)) do --리수스타일 배열을 다시 테이블로
        local content = json.decode(getLoreBookContent(triggerId, v..".init")) -- 대상 캐릭터의 로어북을 불러와 테이블로 저장
        --[[
        현재 로직을 별도의 캐릭터 생성로직에 포함하고 해당 함수를 가져와서 쓰는 방식을 고려할것.
        ]]

        --캐릭터에는 정의가 필요한 부분만 넣고 들어가지 않은 trait, juel등의 필드를 db에서 읽어와서 추가
        local db = {"marks.db", "abl.db", "juel.db", "exp.db", "stat.db"}
        for _, tbl in pairs(db) do
            for key,_ in pairs(json.decode(getLoreBookContent(triggerId, tbl))) do
                if not content[key] then
                    debug(v.."의 캐릭터 테이블에 ".. key.."필드 추가")
                    content[key] = "0"
                end
            end
        end

        --캐릭터 정보를 로컬로어북에 저장
        local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
        upsertLocalLoreBook(triggerId, v, json.encode(content), option)
    end

    --유저 정보를 user변수에 테이블로 할당
    charToVar(triggerId, "user", "user")
end