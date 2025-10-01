--기본 변수
TIME = -1
SPAMING = 0.2
DEBUG = 0
INIT = 0
CHARLIST = {}

--디버깅용
function debug(...)
    if DEBUG==1 then
        print(...)
    end
end

--로어북 주석처리 "///" 제거
function getLoreBookContent(triggerId, lore)
    local rawContent = getLoreBooks(triggerId, lore)[1].content
    local modContent = string.gsub(rawContent, "%s*///[^\n]*\n?", "\n")
    return modContent
end

--초기세팅 함수
function initialize(triggerId)
    if INIT == 0 then
        --INIT = 1
        debug("초기 세팅 개시...")
        local initFuncs ={"initVars.sys"}
        for i, f_code in ipairs(initFuncs) do
            local funcBody = getLoreBookContent(triggerId, f_code)
            local func = createFunctionFromString(funcBody)
            debug(f_code .. " 함수 실행")
            func(triggerId)
        end
        
        setState(triggerId, "screen", "main")
        processAndStoreLore(triggerId, "main.lua")
         
    else
        initialize = function()--함수 무력화
            debug("초기세팅 완료")
        end
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

-- CharInfo 조회용 함수 (작성중)
function charInfo(triggerId, name)
    if name == getPersonaName(triggerId) then
        local name = getPersonaName(triggerId)
    else
        local name = name
    end
    setState(triggerId, "screen", "charInfo")

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

    local pattern = "%[(%w+)/(%w+)/([^%]]+)%]%s*(function.-end)!!"
    local count = 0
    local cmds = ""
    local btns = ""

    for page, number, description, functionBody in loreEntries:gmatch(pattern) do
        local key = page.."_"..number
        setState(triggerId, key, functionBody)
        debug(description.."-> funcs['" .. key .. "']에 함수 저장됨.")
        --print(functionBody)
        count = count + 1

        --cmds 챗변수에 버튼들 입력
        if description == "--" then --구분선 처리
            cmds = cmds .. "<hr style='border:solid 1px;width:100%;margin:0.1em;'>"
        else
            cmds = cmds.."<button class='btn command-btn' risu-btn='"..number.."'>["..number.."] "..description.."</button>"
        end
        
    end
    setChatVar(triggerId, "cmds", cmds)
    reloadDisplay(triggerId)
    debug("처리 완료. 총 " .. count .. "개의 함수를 저장했습니다.\n")
end

function executeFunction(triggerId, screen, f_code, ...)
    local f_code = screen.."_"..f_code
    local funcBody = getState(triggerId, f_code)

    if not funcBody then
        alertNormal(triggerId, "커맨드 오류: " .. (err or "존재하지 않는 커맨드"))
        return
    else
        local func, err = createFunctionFromString(funcBody)
        debug(f_code .. " 함수 실행")
        func(triggerId, ...)
    end
end

function LLMresponse(triggerId, prompt)
    local prompt = {
        {
            role = "system",
            content = prompt
        }
    }
    local response = LLM(triggerId, prompt)
    if response.success then
        debug("response: " .. response.result)
        return response.result
    else
        print("응답실패")
    end

end

listenEdit("editDisplay", function(triggerId, data)
    local screen = getState(triggerId, "screen")
    if not screen then
        setState(triggerId, "screen", "gameStart")
        screen = getState(triggerId, "screen")
        --processAndStoreLore(triggerId, screen..".lua")
    end

    --현재 페이지에 맞는 html호출
    local html = getLoreBookContent(triggerId, screen..".html")
    setChatVar(triggerId, "html", html)
end)

--기본 입력창을 통해 리퀘가 가는걸 방지 + 입력한 번호 캐치해서 함수수행
onStart = async(function(triggerId)
    if time-TIME < SPAMING then
        alertError(triggerId, "메시지가 단 시간에 너무 많이 입력되었습니다.")
        removeChat(triggerId, getChatLength(triggerId)-1)
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

    return false
end)

onButtonClick = async(function(triggerId, data)
    if time()-TIME < SPAMING then
        print(time, TIME)
        alertError(triggerId, "메시지가 단 시간에 너무 많이 입력되었습니다.")
        print("스패밍 멈춰!")
        return false
    end

    local screen = getState(triggerId, "screen")
    if data == "gameStart" then
        print("start")
        initialize(triggerId)
    elseif string.find(data, "charInfo") then
        local name = string.match(data, "charInfo_(.*)")
        charInfo(triggerId, name)
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
end)
