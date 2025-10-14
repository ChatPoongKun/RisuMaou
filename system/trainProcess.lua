--조교 커맨드에 따른 LLM의 출력을 처리
function(triggerId, dc, HP, SP, command)
    debug("trainProcess 실행")
    local max_ej = 10000 --최대 절정치

    --버튼 비활성화 및 응답중 표시
    local old_cmds = getChatVar(triggerId, "cmds")
    local loading = [[<div class="loading-container" aria-live="polite" aria-label="응답 처리중">
    <div class="loading-text">[응답 처리중]</div>
    <div class="loading-dots">
    <span class="dot-1"></span>
    <span class="dot-2"></span>
    <span class="dot-3"></span>
    </div>
    </div>]]
    setChatVar(triggerId, "cmds", loading)
    reloadDisplay(triggerId)

    --LLM에 전달할 각종 수치에 대한 설명 호출
    local ablDB = getLoreBooks(triggerId, "abl.db")[1].content:gsub("{",""):gsub("}","")
    local statDB = getLoreBooks(triggerId, "stat.db")[1].content:gsub("{",""):gsub("}","")
    --local expDB = getLoreBooks(triggerId, "exp.db")[1].content --토큰만 먹을텐데 경험 수치에 대한 db를 알려줄 필요가 있을까? 일시 보류
    local traitDB = json.decode(getLoreBookContent(triggerId, "trait.db")) -- target과 관련있는 trait만 골라서 전달하기 위해 테이블로 받아옴

    --유저와 조교대상의 정보 호출
    local user = getLoreBookContent(triggerId, "user") --유저의 정보를 로어북에서 string으로 호출
    local target_c = getChatVar(triggerId, "target") --대상정보를 chatvar에서 string으로 호출
    local target = getState(triggerId, "target") --대상정보를 state에서 테이블로 호출
    local currentStat = getState(triggerId, "stat") --현재 stat을 호출



    --[[성공굴림]]
    --보너스 요소: 유저 기교당 1, 대상의 반발 외 각인당 2, 긍정적 Stat레벨당 1
    --패널티 요소: 대상의 2^반발각인, 부정적 stat당 1
    local rollBonus = 0
    rollBonus = rollBonus + json.decode(user)["레벨"] - 1 --유저 레벨당 1, 1레벨부터 시작이므로 1을 차감
    local marks = json.decode(getLoreBookContent(triggerId, "mark.db"))
    for _, v in ipairs(marks) do -- 각인 보너스 적용
        if v == "반발각인" then
            rollBonus = rollBonus - 2^tonumber(target[v])
        else
            rollBonus = rollBonus + target[v]*2
        end
    end
    local dcPlus = {"C쾌락", "V쾌락", "A쾌락", "B쾌락", "U쾌락", "M쾌락", "S쾌락"} --성공굴림 보너스 stat
    for _, v in ipairs(dcPlus) do
        local val = currentStat[v]
        rollBonus = rollBonus + val
        debug("성공굴림: "..v.." +"..val)
    end
    local dcMinus = {"공포", "불쾌", "부정"} --성공굴림 마이너스 stat
    for _, v in ipairs(dcMinus) do
        local val = currentStat[v]
        rollBonus = rollBonus - val
        debug("성공굴림: "..v.." -"..val)
    end
    --상황에 따라 달라지는 stat: "굴복", "수치", "고통"
    local dcCon = 0
    dcCon = currentStat["굴복"] or 0
    if hasVal(target, "복종각인") == true or tonumber(target["봉사기술"])> 4 then
        rollBonus = rollBonus + dcCon
        debug("성공굴림: 굴복 +"..dcCon)
    else
        rollBonus = rollBonus - dcCon
        debug("성공굴림: 굴복 -"..dcCon)
    end
    dcCon = currentStat["수치"] or 0
    if tonumber(target["노출벽"])> 4 then
        rollBonus = rollBonus + dcCon
        debug("성공굴림: 수치 +"..dcCon)
    else
        rollBonus = rollBonus - dcCon
        debug("성공굴림: 수치 -"..dcCon)
    end
    dcCon = currentStat["고통"] or 0
    if tonumber(target["마조끼"])> 4 then
        rollBonus = rollBonus + dcCon
        debug("성공굴림: 고통 +"..dcCon)
    else
        rollBonus = rollBonus - dcCon
        debug("성공굴림: 고통 -"..dcCon)
    end

    --최종 주사위굴림
    local roll = math.random(1, MAXROLL)
    local rollMsg = ""
    if roll == MAXROLL then
        rollMsg = "조교 대성공!"
        print(roll..">="..dc, rollMsg)
    elseif roll + rollBonus <= dc then
        rollMsg = "조교 실패"
        print(roll..">="..dc, rollMsg)
    else
        print(roll..">="..dc, "성공")
        
    end

    --HP,SP 소모 계산
    local costHP, costSP
    if string.gmatch(roll, "실패") then --조교가 실패하는 경우 체력 기력소모 증가
        costHP = HP *1.5
        costSP = SP *1.5
    elseif string.gmatch(roll, "대성공") then --조교가 대성공 하면 체력 기력 소모 감소
        costHP = HP *0.8
        costSP = SP *0.8
    end
    local hp, sp = tonumber(target["체력"]), tonumber(target["기력"])
    sp = sp - costSP
    if sp < 0 then --기력이 부족한 경우 기력 소모의 두배만큼 체력소모
        hp = hp - sp *2
        sp = 0
    end
    hp = math.max(hp - costHP, 0)
    --[[
        HP가 낮을 경우 설정에 따라 실신 혹은 사망 처리
    ]]
    
    --계산된 체력 기력을 콤마가 포함된 문자열로 변환해 저장
    target["체력"] = int(hp)
    target["기력"] = int(sp)

    

    
    --[[프롬프트 빌딩]]
    --기존 로그 불러옴
    local log = getChatVar(triggerId, "trainLog")
    --target가 가진 trait만 추출해 LLM에 정보제공
    for k, _ in pairs(traitDB) do
        if not hasVal(target, k) then
            traitDB[k] = nil --target한테 없는 trait 설명은 삭제
        end
    end
    traitDB = json.encode(traitDB)
    --스탯을 n/10으로 작성해 LLM이 현재 수준이 어느정도인지 판단하도록 함
    local statProm = {}
    for k,v in pairs(currentStat) do
        statProm[k] = v.."/10"
    end
    local prompt = {
    promptBuild("system", getLoreBookContent(triggerId, "system.pt")),
    promptBuild("system", getLoreBookContent(triggerId, "train.pt")),
    promptBuild("system", ablDB),
    promptBuild("system", statDB),
    promptBuild("system", traitDB),
    promptBuild("system", user),
    promptBuild("system", target_c),
    promptBuild("system", json.encode(statProm)),
    promptBuild("assistant", log),
    promptBuild("user", command)
    }
    if rollMsg ~= "" then
        table.insert(prompt, promptBuild("system", rollMsg))
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
    local ej_target = getChatVar(triggerId, "ej_target")
    ej_target = ej_target*0.95 --매턴마다 절정치는 자연감소

    local ejPlus = {"C쾌락", "V쾌락", "A쾌락", "B쾌락", "U쾌락", "M쾌락", "S쾌락"} --절정치를 증가시키는 stat
    for k, v in ipairs(ejPlus) do
        local val = statChange[v] or 0
        ej_target = ej_target + val
        debug(k..": +"..v)
    end

    local ejMinus = {"공포", "불쾌", "부정"} --절정치를 감소시키는 stat
    for k, v in ipairs(ejMinus) do
        local val = statChange[v] or 0
        ej_target = ej_target - val
        debug(k..": -"..v)
    end

    --상황에 따라 달라지는 stat: "굴복", "수치", "고통"
    local ejCon
    ejCon = statChange["굴복"] or 0
    if hasVal(target, "복종각인") == true or tonumber(target["봉사기술"])> 4 then
        ej_target = ej_target + ejCon
        debug("굴복: +"..ejCon)
    else
        ej_target = ej_target - ejCon
        debug("굴복: -"..ejCon)
    end
    ejCon = statChange["수치"] or 0
    if tonumber(target["노출벽"])> 4 then
        ej_target = ej_target + ejCon
        debug("수치: +"..ejCon)
    else
        ej_target = ej_target - ejCon
        debug("수치: -"..ejCon)
    end
    ejCon = statChange["고통"] or 0
    if tonumber(target["마조끼"])> 4 then
        ej_target = ej_target + ejCon
        debug("고통: +"..ejCon)
    else
        ej_target = ej_target - ejCon
        debug("고통: -"..ejCon)
    end

    --절정치가 최대 최소값을 넘지 않도록 후처리
    ej_target = math.min(max_ej, math.max(0, math.floor(ej_target)))
    setChatVar(triggerId, "ej_target", ej_target)
    debug(target["이름"].."절정치: " .. ej_target)

    --절정여부 체크
    local orgasm_t, orgasm_u = false, false
    if ej_target > max_ej then
        orgasm_t = true
    end
    --[[유저 절정처리 미구현
        if ej_user > max_ej then
            orgasm_u = true
        end
    ]]

    --스탯변화값을 가져와 currentstat이 레벨업 하는지를 stat.db의 테이블의 각 레벨값과 비교해 확률적으로 계산    
    local lvUpcomment = ""
    local tbl = json.decode(getLoreBookContent(triggerId, "EXPtable.db"))
    local statResult = {}
    math.randomseed(os.time())

    local lvUp
    lvUp = function(remainStat , currentLv, statName)
        local lv = currentLv
        local remainStat = remainStat 
        local r = math.random()
        debug(statName..": "..remainStat.."/"..tbl[lv]..": "..remainStat/tbl[lv] .. " >= " .. r)
        if remainStat/tbl[lv] >= r then
            remainStat = math.max(remainStat - tbl[lv], 0)
            lv = tostring(lv + 1)
            lv = lvUp(remainStat, lv, statName)
            return lv
        else
            return lv
        end
    end

    for k, _ in pairs(currentStat) do
        local v = statChange[k] or "0" -- statChange에 해당 키값이 없을 경우 0을 반환하도록 해 에러방지
        local lv = tostring(currentStat[k])
        if tonumber(v) > 0 then
            statResult[k] = tonumber(lvUp(v, lv, k))
            currentStat[k] = tonumber(currentStat[k])
            if currentStat[k] < statResult[k] then
                lvUpcomment = lvUpcomment.. "<br>※ " .. k .. "이(가) " .. currentStat[k] .. "에서 " .. statResult[k] .. "로 증가했습니다!"
            end
        else
            statResult[k] = lv
        end
    end
    setChatVar(triggerId, "cmds", old_cmds) --버튼 원복
    setChatVar(triggerId, "statLvUp", lvUpcomment) --stat 변화 설명은 log에 포함되지 않도록 정규식 처리
    setState(triggerId, "stat", statResult) --변경된 stat을 state에 반영
    local stat_c = "{"
    for k, v in pairs(statResult) do
        stat_c = stat_c .. '"'..k..'":"'..v..'",'
    end
    stat_c = string.gsub(stat_c, ",$", "}")-- 마지막 쉼표 대신 중괄호 닫기
    setChatVar(triggerId, "stat", stat_c) --변경된 stat을 chatVar에 반영

    --조교간에 변경된 유저 또는 대상의 정보(hp, sp 절정경험 등)은 state와 챗변수에 쌓아뒀다가 조교 종료시에 로어북으로 반영.
    setState(triggerId, "target", target)
    stateToVar(triggerId, target, "target")

    reloadDisplay(triggerId)
    setChatVar(triggerId, "trainLog", log)

    return orgasm_t, orgasm_u --대상과 유저의 절정 여부 반환

end