function (triggerId)
    --초기 변수 설정
    print("initVars 실행")
    local initVars = {
        gold = "10,000",
        day = 1,
        ampm = 0, --0은 오전 1은 오후
        chars = '["user","마오"]', --리수배열 스타일에 맞게 저장
        difficulty = "보통", --조교난이도
        blockDeath = 1, --사망방지. 기본값 OFF
        history = 0, --과거 조교기록 보기. 기본값 OFF
        debug = DEBUG,
    }

    for key, value in pairs(initVars) do
        setChatVar(triggerId, key, value)
    end

    --user 및 고유캐릭터 정보를 로컬 로어북에 저장
    local juel = {}
    for _, v in ipairs(json.decode(initVars.chars)) do --리수스타일 배열을 다시 테이블로
        local content = json.decode(getLoreBookContent(triggerId, v..".init")) -- 대상 캐릭터의 로어북을 불러와 테이블로 저장
        --[[
        현재 로직을 별도의 캐릭터 생성로직에 포함하고 해당 함수를 가져와서 쓰는 방식을 고려할것.
        ]]

        --캐릭터에는 정의가 필요한 부분만 들어있음. 캐릭터 시트에 없는 trait, juel등의 필드를 db에서 읽어와서 추가
        local db = {"mark.db", "abl.db", "exp.db"}
        local added = ""
        for _, tbl in pairs(db) do
            for key,_ in pairs(json.decode(getLoreBookContent(triggerId, tbl))) do
                if not content[key] then
                    content[key] = "0"
                    added = added .. ", ".. key
                end
            end
        end
        debug(v.."의 캐릭터 테이블에 ".. added.."필드 추가")

        --캐릭터 정보를 로컬로어북에 저장
        local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
        upsertLocalLoreBook(triggerId, v, json.encode(content), option)

        --주얼은 별도의 state로 저장
        local jueldb = json.decode(getLoreBookContent(triggerId, "juel.db"))
        juel[v] = {}
        for j, _ in pairs(jueldb) do
            juel[v][j] = 0
        end
    end
    setState(triggerId, "juel", juel)

    --유저 정보를 user변수에 테이블로 할당
    local user = json.decode(getLoreBookContent(triggerId, "user"))
    stateToVar(triggerId, "user", user)

    --abl.db에서 각 카테고리의 모든 항목 키값을 각각의 카테고리명 챗변수로 저장
    local abl = json.decode(getLoreBookContent(triggerId, "abl.db"))
    local abl_tbl = "["
    for k, _ in pairs(abl) do
        abl_tbl = abl_tbl..'"'..k..'",'
    end
    abl_tbl = string.gsub(abl_tbl, ",$", "]")-- 마지막 쉼표 대신 괄호 닫기
    setChatVar(triggerId, "ablList", abl_tbl)

    --exp.db에서 각 카테고리의 모든 항목 키값을 각각의 카테고리명 챗변수로 저장
    local exp = json.decode(getLoreBookContent(triggerId, "exp.db"))
    local exp_tbl = "["
    for k, _ in pairs(exp) do
        exp_tbl = exp_tbl..'"'..k..'",'
    end
    exp_tbl = string.gsub(exp_tbl, ",$", "]")-- 마지막 쉼표 대신 괄호 닫기
    setChatVar(triggerId, "expList", exp_tbl)

    --juel.db에서 각 카테고리의 모든 항목 키값을 각각의 카테고리명 챗변수로 저장
    local juel = json.decode(getLoreBookContent(triggerId, "juel.db"))
    local juel_tbl = "["
    for k, _ in pairs(juel) do
        juel_tbl = juel_tbl..'"'..k..'",'
    end
    juel_tbl = string.gsub(juel_tbl, ",$", "]")-- 마지막 쉼표 대신 괄호 닫기
    setChatVar(triggerId, "juelList", juel_tbl)

    --trait.db에서 각 카테고리의 모든 항목 키값을 각각의 카테고리명 챗변수로 저장
    local trait = json.decode(getLoreBookContent(triggerId, "trait.db"))
    for cat, tbl in pairs(trait) do
        local flat_tbl = flatten(tbl)
        local cat_tbl = "["
        for k, _ in pairs(flat_tbl) do
            cat_tbl = cat_tbl..'"'..k..'",'
        end
        cat_tbl = string.gsub(cat_tbl, ",$", "]")-- 마지막 쉼표 대신 괄호 닫기
        setChatVar(triggerId, cat.."List", cat_tbl)
    end

    addChat(triggerId, "user", "{{".."getvar::html".."}}")
end