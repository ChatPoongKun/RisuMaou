--기본 변수
TIME = -1
SPAMING = 0.2
DEBUG = 0
MAXROLL = 30

--디버깅용
function debug(...)
    if DEBUG==1 then
        print(...)
    end
end

--tonumber를 콤마제거후 숫자로 인식하도록 오버라이딩
old_tonumber = tonumber
tonumber = function(str, base)
  if type(str) == "string" then
    local cleaned_str = string.gsub(str, ",", "")
    return old_tonumber(cleaned_str, base)
  else
    return str, base
  end
end

--시간값 출력
function time()
    if os.clock()<0 then
        return os.time()
    else
        return os.clock() --35분 지나면 오버플로우로 못씀
    end
end

--정수 포맷팅
function int(str)
    if tonumber(str) ~= nil and tonumber(str)>=1000 then --숫자변환이 불가하면 바이패스하고 입력값을 다시 반환
        str = string.reverse(string.reverse(string.format("%.0f", str)):gsub("(%d%d%d)", "%1,"))
    end
    return str
end

--테이블 길이 파악
function len(tbl)
    local len = 0
    if type(tbl) ~= "table" then
        debug(tbl.."은 올바른 테이블이 아닙니다.")
        return false
        end
    for k, v in pairs(tbl) do
        len = len + 1
    end
    return len
end


--table에 val이 있는지 확인.
--신체특성 같은 배열 내에 있는 값도 체크하기 위해 밸류도 함께 체크
--return으로 밸류를 반환하도록 해 함수 활용성을 높임
function hasVal(tbl, val)
    for k, v in pairs(tbl) do
        if k == val or v == val then
            return true, v
        end
        if type(v) == "table" then
            local found , foundVal = hasVal(v, val)
            if found then
                return found, foundVal
            end
        end
    end
    return false, nil
end

--로어북 컨텐츠 로딩
function getLoreBookContent(triggerId, lore)
    local rawContent = getLoreBooks(triggerId, lore)[1].content
    local modContent = string.gsub(rawContent, "%s*///[^\n]*\n?", "\n") --로어북 주석처리 "///" 제거
    return modContent
end

--테이블을 1차원으로 flatten
function flatten(tbl)
    local result = {}
    -- 입력된 테이블의 모든 요소를 순회
    local function doFlatten(tbl)
        for k, v in pairs(tbl) do
            if type(v) == "table" then --값이 테이블이면 재귀
                if k == "이상경험 기록" then
                    result[k] = v --이상경험 기록은 평탄화 금지. 개선방안 고민 필요함    
                end
                doFlatten(v)
            elseif type(k) == "number" then --키가 인덱스(배열)이면 키값에 값을 넣고 밸류는 "1"
                result[v] = "1"
            else
                result[k] = v --일반적인 키:값 상태면 그대로 입력
            end
        end
    end
    doFlatten(tbl)
    return result
end

-- state에 저장된 테이블을 챗변수varName으로 할당. 입력된 테이블을 1차원으로 flatten함
function stateToVar(triggerId, key, tbl)
    --테이블을 리수 딕셔너리/배열 양식에 맞게 변형 
    local tbl = flatten(tbl)
    local new_tbl = ""
    local function checkArray(v) --배열인지 확인
        for k,_ in pairs(v) do
            if type(k) ~= "number" then
                return false
            end
        end
        return true
    end

    if checkArray(tbl) then --tbl이 배열이면
        --배열처리
        new_tbl = "["
        for _,v in pairs(tbl) do
            new_tbl = new_tbl .. '"' .. v .. '",'
        end
        new_tbl = string.gsub(new_tbl, ",$", "]")
    else
        --딕셔너리처리
        new_tbl = "{"
        for k, v in pairs(tbl) do
            if type(v) == "table" then --이상경험기록은 평탄화 안해서 값이 테이블이므로 encode해서 집어넣음 추후 개선안 필요함.
                v = json.encode(v)
            end
            new_tbl = new_tbl .. '"' .. k .. '":"' .. v .. '",'
        end
        new_tbl = string.gsub(new_tbl, ",$", "}")

    end
    debug("state to chatVar: "..key, new_tbl)
    setChatVar(triggerId, key, new_tbl)

end

--초기세팅 함수
function initialize(triggerId)
    debug("초기 세팅 개시...")
    local initFuncs ={"initVars.sys", "debugCmds.sys"} --향후 초기 설정 함수를 더 추가할 수 있도록 테이블 선언
    for i, f_code in ipairs(initFuncs) do
        sysFunction(triggerId, f_code)
    end
    setState(triggerId, "screen", "main")
    processAndStoreLore(triggerId, "main.lua")
end

-- 문자열 함수를 실제 함수 객체로 변환
function createFunctionFromString(functionString)
    local returnableString = "return " .. functionString
    
    local chunk, errorMessage = load(returnableString, "lore_function", "t", _G)
    if not chunk then
        return nil, "컴파일 오류: " .. (errorMessage or "알 수 없음")
    end

    local success, result = pcall(chunk)
    if success and type(result) == "function" then
        return result, nil
    else
        return nil, "실행 오류: " .. tostring(result)
    end
end

--- 로어 텍스트를 처리하여 funcs 테이블에 저장
function processAndStoreLore(triggerId, loreBookId)
    -- 1. loreBookId를 이용해 실제 로어 내용들을 가져옴
    debug(loreBookId .. "로어북에서 함수 호출")
    local loreEntries = getLoreBookContent(triggerId, loreBookId)

    local pattern = "%[(%w+)/(%S+)/([^%]]+)%]%s*(function.-end)!!"
    local count = 0
    local cmds = ""
    local funcs = getState(triggerId, "funcs") or {}

    for page, number, description, functionBody in loreEntries:gmatch(pattern) do
        local key = page.."_"..number
        funcs[key] = functionBody
        debug(description.."-> funcs['" .. key .. "']에 함수 저장됨.")
        count = count + 1

        --cmds 챗변수에 버튼들 입력
        if number == "hr" then --구분선 처리
            cmds = cmds .. "<div style='text-align:center;border-bottom:solid 1px;width:100%;margin:0.1em;grid-column:1/-1;'>"..description.."</div>"
        elseif description ~= "hidden" then
            cmds = cmds.."<button class='btn command-btn' risu-btn='"..number.."'>["..number.."] "..description.."</button>"
        end
        
    end
    setChatVar(triggerId, "cmds", cmds)
    setState(triggerId, "funcs", funcs)
    reloadDisplay(triggerId)
    debug("처리 완료. 총 " .. count .. "개의 함수를 저장했습니다.\n")
end

function executeFunction(triggerId, screen, code, ...)
    local f_code = screen.."_"..code
    local funcs = getState(triggerId, "funcs")
    local funcBody = funcs[f_code]

    if not funcBody then
        funcBody = funcs[code]
        if not funcBody then
            alertNormal(triggerId, "커맨드 오류: " .. (err or "존재하지 않는 커맨드"))
            return
        end
    end
        local func, err = createFunctionFromString(funcBody)
        debug(f_code .. " 함수 실행")
        func(triggerId, ...)
end

function sysFunction(triggerId, f_code, ...)
    local funcBody = getLoreBookContent(triggerId, f_code)
    if not funcBody then
        alertNormal(triggerId, "시스템 커맨드 오류: " .. (err or "존재하지 않는 커맨드"))
        return
    end
    local func, err = createFunctionFromString(funcBody)
    debug(f_code .. " 함수 실행")
    func(triggerId, ...)
end

function promptBuild(role, content)
    local prompt = {
        role = role,
        content = content
    }
    return prompt
end

listenEdit("editDisplay", function(triggerId, data)
    local screen = getState(triggerId, "screen")
    if not screen then
        setState(triggerId, "screen", "gameStart")
        screen = getState(triggerId, "screen")
    end

    --현재 페이지에 맞는 html호출
    local html = getLoreBookContent(triggerId, screen..".html")
    setChatVar(triggerId, "html", html)
    local gameStart = getLoreBookContent(triggerId, "gameStart.html")
    setChatVar(triggerId, "gamestart", gameStart)
    if gameStart ~= html then
        setChatVar(triggerId, "gamestart", "")
    end
end)

--기본 입력창을 통해 리퀘가 가는걸 방지 + 입력한 번호 캐치해서 함수수행
onStart = async(function(triggerId)
    if time()-TIME < SPAMING then
        print(time, TIME)
        alertError(triggerId, "메시지가 단 시간에 너무 많이 입력되었습니다.")
        print("스패밍 멈춰!")
        return false
    end
    local success, command = pcall(getUserLastMessage, triggerId)
    debug(success, command)
    if command == null then
        print("리퀘 차단")
        return false
    end
    removeChat(triggerId, getChatLength(triggerId)-1)
    local screen = getState(triggerId, "screen")
    debug("현재 " .. screen.." 화면에 있습니다.")
    executeFunction(triggerId, screen, command)
    debug("리퀘 차단")

    --현재 페이지에 맞는 html호출
    screen = getState(triggerId, "screen")
    local html = getLoreBookContent(triggerId, screen..".html")
    setChatVar(triggerId, "html", html)
    debug(screen..".html 화면을 갱신합니다.")
    processAndStoreLore(triggerId, screen..".lua")
    TIME = time()

    return false
end)

onButtonClick = async(function(triggerId, data)
    if data == "gameStart" then
        initialize(triggerId)
        print("게임 시작")
    else
        --스팸처리
        if time()-TIME < SPAMING then
            debug(time, TIME)
            alertError(triggerId, "메시지가 단 시간에 너무 많이 입력되었습니다.")
            print("스패밍 멈춰!")
            return false
        end

        local screen = getState(triggerId, "screen")
        if string.find(data, "charInfo") then --캐릭터카드 클릭시 작동
            --local cmd = string.match(data, "(.*)_charInfo") --숫자입력을 통한 캐릭터 선택의 구현은 추후 고민
            local name = string.match(data, "charInfo_(.*)")
            local f_code = "charCard.sys"
            sysFunction(triggerId, f_code, name)
        else
            executeFunction(triggerId, screen, data)
        end

        --현재 페이지에 맞는 html호출
        screen = getState(triggerId, "screen")
        local html = getLoreBookContent(triggerId, screen..".html")
        setChatVar(triggerId, "html", html)
        debug(screen..".html 화면을 갱신합니다.")
        processAndStoreLore(triggerId, screen..".lua")
        TIME = time()
    end
end)