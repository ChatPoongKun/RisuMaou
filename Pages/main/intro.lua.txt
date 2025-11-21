[intro/user/hidden] function(triggerId)
    local introCat = "user"
    setChatVar(triggerId, "category", introCat)
end!!

[intro/king/hidden] function(triggerId)
    local introCat = "king"
    setChatVar(triggerId, "category", introCat)
end!!

[intro/play/hidden] function(triggerId)
    local introCat = "play"
    setChatVar(triggerId, "category", introCat)
end!!

[intro/system/hidden] function(triggerId)
    local introCat = "system"
    setChatVar(triggerId, "category", introCat)
end!!



[intro/userGender/hidden] function(triggerId)
    local user = json.decode(getChatVar(triggerId, "user"))
    local userGender = alertSelect(triggerId, {"남성", "여성", "후타나리"}):await()
    if userGender == "0" then
        user["성별"] = "남성"
        user["가슴"] = nil
        user["유두"] = nil
        user["페니스"] = user["페니스"] or "평범"
    elseif userGender == "1" then
        user["성별"] = "여성"
        user["가슴"] = user["가슴"] or "평범"
        user["유두"] = user["유두"] or "갈색"
        user["페니스"] = nil
    elseif userGender == "2" then
        user["성별"] = "후타나리"
        user["가슴"] = user["가슴"] or "평범"
        user["유두"] = user["유두"] or "갈색"
        user["페니스"] = user["페니스"] or "평범"
    end
    user = json.encode(user)
    setChatVar(triggerId, "user", user)
    local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
    upsertLocalLoreBook(triggerId, "user", user, option)
end!!

[intro/userAge/hidden] function(triggerId)
    local user = json.decode(getChatVar(triggerId, "user"))
    local userAge = alertSelect(triggerId, {"어림", "청년", "중년", "노년"}):await()
    if userAge == "0" then
        user["외형"] = "어림"
    elseif userAge == "1" then
        user["외형"] = "청년"
    elseif userAge == "2" then
        user["외형"] = "중년"
    elseif userAge == "3" then
        user["외형"] = "노년"
    end
    user = json.encode(user)
    setChatVar(triggerId, "user", user)
    local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
    upsertLocalLoreBook(triggerId, "user", user, option)
end!!

[intro/userHair/hidden] function(triggerId)
    local user = json.decode(getChatVar(triggerId, "user"))
    local userHair = alertInput(triggerId, "헤어스타일을 묘사하세요."):await()
    if userHair ~= "" then
        user["헤어스타일"] = userHair
    end
    user = json.encode(user)
    setChatVar(triggerId, "user", user)
    local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
    upsertLocalLoreBook(triggerId, "user", user, option)
end!!

[intro/userBreast/hidden] function(triggerId)
    local user = json.decode(getChatVar(triggerId, "user"))
    local userBreast = alertSelect(triggerId, {"절벽", "빈유", "평범", "거유", "폭유"}):await()
    if userBreast == "0" then
        user["가슴"] = "절벽"
    elseif userBreast == "1" then
        user["가슴"] = "빈유"
    elseif userBreast == "2" then
        user["가슴"] = "평범"
    elseif userBreast == "3" then
        user["가슴"] = "거유"
    elseif userBreast == "4" then
        user["가슴"] = "폭유"
    end
    user = json.encode(user)
    setChatVar(triggerId, "user", user)
    local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
    upsertLocalLoreBook(triggerId, "user", user, option)
end!!

[intro/userTit/hidden] function(triggerId)
    local user = json.decode(getChatVar(triggerId, "user"))
    local userTit = alertSelect(triggerId, {"갈색", "핑크", "함몰"}):await()
    if userTit == "0" then
        user["유두"] = "갈색"
    elseif userTit == "1" then
        user["유두"] = "핑크"
    elseif userTit == "2" then
        user["유두"] = "함몰"
    end
    user = json.encode(user)
    setChatVar(triggerId, "user", user)
    local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
    upsertLocalLoreBook(triggerId, "user", user, option)
end!!

[intro/userPubes/hidden] function(triggerId)
    local user = json.decode(getChatVar(triggerId, "user"))
    local userPubes = alertSelect(triggerId, {"없음", "짧음", "보통", "무성함"}):await()
    if userPubes == "0" then
        user["음모"] = "없음"
    elseif userPubes == "1" then
        user["음모"] = "짧음"
    elseif userPubes == "2" then
        user["음모"] = "보통"
    elseif userPubes == "3" then
        user["음모"] = "무성함"
    end
    user = json.encode(user)
    setChatVar(triggerId, "user", user)
    local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
    upsertLocalLoreBook(triggerId, "user", user, option)
end!!

[intro/userPenis/hidden] function(triggerId)
    local user = json.decode(getChatVar(triggerId, "user"))
    local userPenis = alertInput(triggerId, "당신의 페니스 크기는?(cm)"):await()
    
    if not tonumber(userPenis) then
        return
    end

    userPenis = tonumber(userPenis)
    if userPenis <= 5 then
        user["페니스"] = "실좆"
    elseif userPenis <= 10 then
        user["페니스"] = "작음"
    elseif userPenis <= 15 then
        user["페니스"] = "평범"
    elseif userPenis <= 25 then
        user["페니스"] = "대물"
    elseif  userPenis > 25 then
        user["페니스"] = "말자지"
    end
    user = json.encode(user)
    setChatVar(triggerId, "user", user)
    local option = {alwaysActive = false, insertOrder = 100, key = "", secondKey = "", regex = false}
    upsertLocalLoreBook(triggerId, "user", user, option)
end!!




[intro/kingGender/hidden] function(triggerId)
    local king = json.decode(getChatVar(triggerId, "king"))
    local kingGender = alertSelect(triggerId, {"남성", "여성", "후타나리"}):await()
    print(kingGender)
    if kingGender == "0" then
        king["성별"] = "남성"
        king["가슴"] = nil
        king["유두"] = nil
        king["페니스"] = king["페니스"] or "대물"
    elseif kingGender == "1" then
        king["성별"] = "여성"
        king["가슴"] = king["가슴"] or "거유"
        king["유두"] = king["유두"] or "핑크"
        king["페니스"] = nil
    elseif kingGender == "2" then
        king["성별"] = "후타나리"
        king["가슴"] = king["가슴"] or "거유"
        king["유두"] = king["유두"] or "핑크"
        king["페니스"] = king["페니스"] or "대물"
    end
    king = json.encode(king)
    setChatVar(triggerId, "king", king)
end!!

[intro/kingAge/hidden] function(triggerId)
    local king = json.decode(getChatVar(triggerId, "king"))
    local kingAge = alertSelect(triggerId, {"어림", "청년", "중년", "노년"}):await()
    if kingAge == "0" then
        king["외형"] = "어림"
    elseif kingAge == "1" then
        king["외형"] = "청년"
    elseif kingAge == "2" then
        king["외형"] = "중년"
    elseif kingAge == "3" then
        king["외형"] = "노년"
    end
    king = json.encode(king)
    setChatVar(triggerId, "king", king)
end!!

[intro/kingHair/hidden] function(triggerId)
    local king = json.decode(getChatVar(triggerId, "king"))
    local kingHair = alertInput(triggerId, "헤어스타일을 묘사하세요."):await()
    if kingHair ~= "" then
        king["헤어스타일"] = kingHair
    end
    king = json.encode(king)
    setChatVar(triggerId, "king", king)
end!!

[intro/kingBreast/hidden] function(triggerId)
    local king = json.decode(getChatVar(triggerId, "king"))
    local kingBreast = alertSelect(triggerId, {"절벽", "빈유", "평범", "거유", "폭유"}):await()
    if kingBreast == "0" then
        king["가슴"] = "절벽"
    elseif kingBreast == "1" then
        king["가슴"] = "빈유"
    elseif kingBreast == "2" then
        king["가슴"] = "평범"
    elseif kingBreast == "3" then
        king["가슴"] = "거유"
    elseif kingBreast == "4" then
        king["가슴"] = "폭유"
    end
    king = json.encode(king)
    setChatVar(triggerId, "king", king)
end!!

[intro/kingTit/hidden] function(triggerId)
    local king = json.decode(getChatVar(triggerId, "king"))
    local kingTit = alertSelect(triggerId, {"갈색", "핑크", "함몰"}):await()
    if kingTit == "0" then
        king["유두"] = "갈색"
    elseif kingTit == "1" then
        king["유두"] = "핑크"
    elseif kingTit == "2" then
        king["유두"] = "함몰"
    end
    king = json.encode(king)
    setChatVar(triggerId, "king", king)
end!!

[intro/kingPubes/hidden] function(triggerId)
    local king = json.decode(getChatVar(triggerId, "king"))
    local kingPubes = alertSelect(triggerId, {"없음", "짧음", "보통", "무성함"}):await()
    if kingPubes == "0" then
        king["음모"] = "없음"
    elseif kingPubes == "1" then
        king["음모"] = "짧음"
    elseif kingPubes == "2" then
        king["음모"] = "보통"
    elseif kingPubes == "3" then
        king["음모"] = "무성함"
    end
    king = json.encode(king)
    setChatVar(triggerId, "king", king)
end!!

[intro/kingPenis/hidden] function(triggerId)
    local king = json.decode(getChatVar(triggerId, "king"))
    local kingPenis = alertInput(triggerId, "광왕의 페니스 크기는?(cm)"):await()
    
    if not tonumber(kingPenis) then
        return
    end

    kingPenis = tonumber(kingPenis)
    if kingPenis <= 5 then
        king["페니스"] = "실좆"
    elseif kingPenis <= 10 then
        king["페니스"] = "작음"
    elseif kingPenis <= 15 then
        king["페니스"] = "평범"
    elseif kingPenis <= 25 then
        king["페니스"] = "대물"
    elseif  kingPenis > 25 then
        king["페니스"] = "말자지"
    end
    king = json.encode(king)
    setChatVar(triggerId, "king", king)
end!!




[intro/difficulty/hidden] function(triggerId)
    local difficulty = getChatVar(triggerId, "difficulty")

    if difficulty == "쉬움" then
        MAXROLL = 30
        setChatVar(triggerId, "difficulty", "보통")
    elseif difficulty == "보통" then
        MAXROLL = 20
        setChatVar(triggerId, "difficulty", "어려움")
    else
        MAXROLL = 40
        setChatVar(triggerId, "difficulty", "쉬움")
    end
end!!

[intro/blockDeath/hidden] function(triggerId)
    local blockDeath = getChatVar(triggerId, "blockDeath")

    blockDeath = math.abs(blockDeath-1)
    setChatVar(triggerId, "blockDeath", blockDeath)
end!!

[intro/showLog/hidden] function(triggerId)
    local showLog = getChatVar(triggerId, "showLog")
    showLog = math.abs(showLog-1)
    setChatVar(triggerId, "showLog", showLog)
end!!

[intro/debug/hidden] function(triggerId)
    local debug = getChatVar(triggerId, "debug")
    debug = math.abs(debug-1)
    setChatVar(triggerId, "debug", debug)
end!!

[intro/trainResponse/hidden] function(triggerId)
    local models = json.decode(getChatVar(triggerId, "models"))
    local llmSelect = "trainResponse"
    models[llmSelect] = tostring(math.abs(tonumber(models[llmSelect])-1))
    setChatVar(triggerId, "models", json.encode(models))
end!!

[intro/trainLog/hidden] function(triggerId)
    local models = json.decode(getChatVar(triggerId, "models"))
    local llmSelect = "trainLog"
    models[llmSelect] = tostring(math.abs(tonumber(models[llmSelect])-1))
    setChatVar(triggerId, "models", json.encode(models))
end!!



[intro/199/설정완료] function(triggerId)
    local screen = "main"
    setChatVar(triggerId, "category", "items")
    setState(triggerId, "screen", screen)
end!!
