function (triggerId)
    --시간 흐름 처리
    local day = getChatVar(triggerrId, "day")
    local ampm = getChatVar(triggerrId, "ampm")
    local chars = json.decode(getChatVar(triggerrId, "chars"))

    if ampm == "1" then
        --체력/기력 회복처리
        for i, value in ipairs(chars) do
            local heal = 0.1 --회복비율
            local char = json.decode(getLoreBookContent(triggerId, value))
            if hasVal(char, "빠른회복") then
                heal = heal*1.5
            elseif hasVal(char, "느린회복") then
                heal = heal*0.5
            end
            char["체력"] = int(math.min(tonumber(char["체력"]) + tonumber(char["최대체력"])*heal, tonumber(char["최대체력"])))
            char["기력"] = int(math.min(tonumber(char["기력"]) + tonumber(char["최대기력"])*heal, tonumber(char["최대기력"])))

            --수정한 정보를 다시 캐릭터 로어북으로 저장
            local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
            upsertLocalLoreBook(triggerId, value, json.encode(char), option)
        end

        --하루 종료 처리
        alertNormal(triggerId, "하루가 지나갑니다...")
    else
        alertNormal(triggerId, "당신은 휴식을 취합니다.")
    end
    day = day + ampm
    ampm = math.abs(ampm - 1)
    debug(day.."일 "..ampm)
    setChatVar(triggerId, "day", day)
    setChatVar(triggerId, "ampm", ampm)

    charToVar(triggerId, "user", "user") --갱신된 유저정보 변수저장
end