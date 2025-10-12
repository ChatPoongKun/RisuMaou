--조교 커맨드에 따른 LLM의 출력을 처리
function(triggerId, command, roll)
    debug("trainProcess 실행")

    --버튼 비활성화 및 응답중 표시
    local old_cmds = getChatVar(triggerId, "cmds")
    setChatVar(triggerId, "cmds", "<span style='text-align:center;'>[[응답 처리중....]]</span>")
    reloadDisplay(triggerId)

    --LLM에 전달할 각종 수치에 대한 설명 호출
    local ablDB = getLoreBooks(triggerId, "abl.db")[1].content:gsub("{",""):gsub("}","")
    local statDB = getLoreBooks(triggerId, "stat.db")[1].content:gsub("{",""):gsub("}","")
    --local expDB = getLoreBooks(triggerId, "exp.db")[1].content --토큰만 먹을텐데 경험 수치에 대한 db를 알려줄 필요가 있을까? 일시 보류
    local traitDB = json.decode(getLoreBookContent(triggerId, "trait.db")) -- char와 관련있는 trait만 골라서 전달하기 위해 테이블로 받아옴

    --유저와 조교대상의 정보 호출
    local user = getLoreBookContent(triggerId, "user")
    local char = getChatVar(triggerId, "target") --chatvar에서 string으로 정보 호출
    local target = getState(triggerId, "target")
    local currentStat = getState(triggerId, "stat") --현재 stat을 호출
    --char가 가진 trait만 추출
    for k, _ in pairs(traitDB) do
        if not hasVal(target, k) then
            traitDB[k] = nil --char한테 없는 trait 설명은 삭제
        end
    end
    traitDB = json.encode(traitDB)

    local log = getChatVar(triggerId, "trainLog") .. command

    --프롬프트 빌딩
    local prompt = {
    promptBuild("system", getLoreBookContent(triggerId, "system.pt")),
    promptBuild("system", getLoreBookContent(triggerId, "train.pt")),
    promptBuild("system", ablDB),
    promptBuild("system", statDB),
    promptBuild("system", traitDB),
    promptBuild("system", user),
    promptBuild("system", char),
    promptBuild("system", json.encode(currentStat)),
    promptBuild("user", log)
    }
    if roll ~= "" then
        table.insert(prompt, roll)
    end

    local response = LLM(triggerId, prompt) --LLM에 응답 요청
    if not response.success then --LLM응답 실패시 함수 종료
        alertNormal(triggerId, "LLM응답 실패")
        setChatVar(triggerId, "cmds", old_cmds)
        reloadDisplay(triggerId)
        return false
    end

    local content = response.result
    debug("응답: "..content)
    local statChange = content:match("({.*})")
    local dialog = content:gsub(statChange, "")
    statChange = json.decode(statChange)
    log = log .. "<br>" .. dialog:gsub("json","")

    --절정치 계산
    local ejStat = {"C쾌락", "V쾌락", "A쾌락", "B쾌락", "U쾌락", "M쾌락", "S쾌락"}
    local ej_target = getChatVar(triggerId, "ej_target")
    for _, v in ipairs(ejStat) do
        ej_target = ej_target + statChange[v]
    end
    setChatVar(triggerId, "ej_target", ej_target)
    print(target["이름"].."절정치 " .. ej_target)

    --스탯변화값을 가져와 currentstat이 레벨업 하는지를 stat.db의 테이블의 각 레벨값과 비교해 확률적으로 계산    
    local lvUpcomment = ""
    local tbl = json.decode(getLoreBookContent(triggerId, "EXPtable.db"))
    local statResult = {}
    math.randomseed(os.time())

    local lvUp
    lvUp = function(changedStat, currentLv, statName)
        local lv = currentLv
        local remainStat = changedStat
        local r = math.random()
        print(statName..": "..remainStat/tbl[lv] .. " >= " .. r)
        if remainStat/tbl[lv] >= r then
            remainStat = math.max(remainStat - tbl[lv], 0)
            lv = tostring(lv + 1)
            lv = lvUp(remainStat, lv, statName)
            return lv
        else
            return lv
        end
    end

    for k, v in pairs(statChange) do
        if tonumber(v) > 0 then
            local lv = tostring(currentStat[k])
            statResult[k] = tonumber(lvUp(v, lv, k))
            --print(type(currentStat[k]),currentStat[k], type(statResult[k]),statResult[k])
            if currentStat[k] < statResult[k] then
                lvUpcomment = lvUpcomment.. "<br>※ " .. k .. "이(가) " .. currentStat[k] .. "에서 " .. statResult[k] .. "로 증가했습니다!"
            end
        end
    end

    setChatVar(triggerId, "cmds", old_cmds) --버튼 원복
    setChatVar(triggerId, "statLvUp", lvUpcomment) --stat 변화 설명은 log에 포함되지 않도록 정규식 처리
    setState(triggerId, "stat", statResult) --변경된 stat을 state에 반영
    local stat_c = "{"
    for k, v in pairs(currentStat) do
        stat_c = stat_c .. '"'..k..'":"'..v..'",'
    end
    stat_c = string.gsub(stat_c, ",$", "}")-- 마지막 쉼표 대신 중괄호 닫기
    setChatVar(triggerId, "stat", stat_c) --변경된 stat을 chatVar에 반영

    reloadDisplay(triggerId)
    setChatVar(triggerId, "trainLog", log)

end