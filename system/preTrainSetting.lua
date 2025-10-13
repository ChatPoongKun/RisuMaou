function (triggerId, name)
        --조교화면 변수 초기화
        setChatVar(triggerId, "애무계", 1)
        setChatVar(triggerId, "도구계", 0)
        setChatVar(triggerId, "V계", 0)
        setChatVar(triggerId, "A계", 0)
        setChatVar(triggerId, "봉사계", 0)
        setChatVar(triggerId, "하드계", 0)
        setChatVar(triggerId, "trainLog", "대상이 조교 준비중이다.")
        setChatVar(triggerId, "statLvUp", "")
        setChatVar(triggerId, "ej_target", 0) --조교대상 절정치
        setChatVar(triggerId, "ej_user", 0) --유저 절정치
        
        --char를 로어북에서 불러와 1차원으로 flatten
        local char = json.decode(getLoreBookContent(triggerId, name))
        char = flatten(char)

        --스탯 초기화
        setState(triggerId, "target", char) --대상 캐릭터 로어북 정보를 state에 저장
        local statDB =json.decode(getLoreBookContent(triggerId, "stat.db"))
        local stat = {}
        for k, _ in pairs(statDB) do
            stat[k] = 0
        end

        --stat에 영향을 주는 모든 속성을 나열한 후 대상 캐릭터의 데이터를 모두 순회하며 stat에 영향을 주는 항목이 있는지 체크
        --abl같은 특정테이블만 순회하는것보다 확장성이 뛰어남
        local ablBase = 0.2 --abl*ablBase가 stat의 최소치를 보장해 높은 abl의 효과를 보장하도록 함
        local ablRatio = 0.5 --abl*ablRatio*math.random()을 더해 매 조교마다 조금씩 다른 stat치로 시작하도록 함
        local statBonus = {
            --abl
            ["C감각"] = function(v)
                stat["C쾌락"] = stat["C쾌락"] + v*(ablBase + ablRatio*math.random()) --자동 형변환 하겠지..
            end,
            ["B감각"] = function(v)
                stat["B쾌락"] = stat["B쾌락"] + v*(ablBase + ablRatio*math.random())
            end,
            ["V감각"] = function(v)
                stat["V쾌락"] = stat["V쾌락"] + v*(ablBase + ablRatio*math.random())
            end,
            ["A감각"] = function(v)
                stat["A쾌락"] = stat["A쾌락"] + v*(ablBase + ablRatio*math.random())
            end,
            ["U감각"] = function(v)
                stat["U쾌락"] = stat["U쾌락"] + v*(ablBase + ablRatio*math.random())
            end,
            ["M감각"] = function(v)
                stat["M쾌락"] = stat["M쾌락"] + v*(ablBase + ablRatio*math.random())
            end,
            ["V확장"] = function(v)--확장이 높아지면 쾌감이 감소
                stat["V쾌락"] = stat["V쾌락"] - v*(ablBase + ablRatio*math.random())*0.5
                stat["V윤활"] = stat["V윤활"] + v*(ablBase + ablRatio*math.random())*1.5
            end,
            ["A확장"] = function(v)--확장이 높아지면 쾌감이 감소
                stat["A쾌락"] = stat["A쾌락"] - v*(ablBase + ablRatio*math.random())*0.5
                stat["A윤활"] = stat["A윤활"] + v*(ablBase + ablRatio*math.random())*1.5
            end,
            ["U확장"] = function(v)--확장이 높아지면 쾌감이 감소. 요도의 경우에는 확장되지 않으면 할 수 있는게 적으므로 패널티 감소
                stat["U쾌락"] = stat["U쾌락"] - v*(ablBase + ablRatio*math.random())*0.2
                stat["V윤활"] = stat["V윤활"] + v*(ablBase + ablRatio*math.random())*1.2 --V윤활이라도 올려줘야..
            end,
            ["순종"] = function(v)
                stat["온순"] = stat["온순"] + v*(ablBase + ablRatio*math.random())
            end,
            ["욕망"] = function(v)
                stat["욕정"] = stat["욕정"] + v*(ablBase + ablRatio*math.random())
            end,
            ["봉사기술"] = function(v)
                stat["굴복"] = stat["굴복"] + v*(ablBase + ablRatio*math.random())*0.5
                stat["온순"] = stat["온순"] + v*(ablBase + ablRatio*math.random())*0.25
                stat["습득"] = stat["습득"] + v*(ablBase + ablRatio*math.random())*0.25
            end,
            ["성교기술"] = function(v)
                stat["욕정"] = stat["욕정"] + v*(ablBase + ablRatio*math.random())*0.2
                stat["습득"] = stat["습득"] + v*(ablBase + ablRatio*math.random())*0.2
                stat["온순"] = stat["온순"] + v*(ablBase + ablRatio*math.random())*0.1
                stat["C쾌락"] = stat["C쾌락"] + v*(ablBase + ablRatio*math.random())*0.1
                stat["V쾌락"] = stat["V쾌락"] + v*(ablBase + ablRatio*math.random())*0.1
                stat["A쾌락"] = stat["A쾌락"] + v*(ablBase + ablRatio*math.random())*0.1
                stat["B쾌락"] = stat["B쾌락"] + v*(ablBase + ablRatio*math.random())*0.1
                stat["V윤활"] = stat["V윤활"] + v*(ablBase + ablRatio*math.random())*0.1
            end,
            ["노출벽"] = function(v)
                stat["굴복"] = stat["굴복"] + v*(ablBase + ablRatio*math.random())*0.5
                stat["수치"] = stat["수치"] + v*(ablBase + ablRatio*math.random())*0.5
            end,
            ["마조끼"] = function(v)
                stat["굴복"] = stat["굴복"] + v*(ablBase + ablRatio*math.random())*0.5
                stat["고통"] = stat["고통"] + v*(ablBase + ablRatio*math.random())*0.5
            end,

            --trait_체질
            ["성교중독"] = function(v)
                stat["온순"] = stat["온순"] + 0.5
                stat["V쾌락"] = stat["V쾌락"] + 0.25
                stat["A쾌락"] = stat["A쾌락"] + 0.25
            end,
            ["자위중독"] = function(v)
                stat["온순"] = stat["온순"] + 0.5
                stat["V윤활"] = stat["V윤활"] + 0.5
                stat["A윤활"] = stat["A윤활"] + 0.5
            end,
            ["정액중독"] = function(v)
                stat["굴복"] = stat["굴복"] + 0.5
                stat["습득"] = stat["습득"] + 0.5
                    end,
            ["매춘중독"] = function(v)
                stat["온순"] = stat["온순"] + 0.5
            end,
            ["방뇨중독"] = function(v)
                stat["수치"] = stat["수치"] + 1.5
                stat["불쾌"] = stat["불쾌"] + 0.5
            end,
            ["촉수중독"] = function(v)
                stat["온순"] = stat["온순"] + 0.5
            end,
            ["수간중독"] = function(v)
                stat["온순"] = stat["온순"] + 0.5
            end,
            ["상시발정"] = function(v)
                stat["V윤활"] = stat["V윤활"] + 1
            end,

            --trait_칭호
            ["음란"] = function(v)
                stat["V윤활"] = stat["V윤활"] + 2
                stat["욕정"] = stat["욕정"] + 3
            end,
            ["연모"] = function(v)
                stat["온순"] = stat["온순"] + 5
            end,
            ["암캐"] = function(v)
                stat["C쾌락"] = stat["C쾌락"] + 1
                stat["V쾌락"] = stat["V쾌락"] + 1
                stat["A쾌락"] = stat["A쾌락"] + 1
                stat["B쾌락"] = stat["B쾌락"] + 1
                stat["욕정"] = stat["욕정"] + 1
            end,
            ["붕괴"] = function(v)
                stat["공포"] = stat["공포"] + 5
            end,
            ["광기"] = function(v)
                stat["부정"] = stat["부정"] + 5
            end
        }

        --평탄화된 char테이블을 순회하며 statBonus 적용
        for k ,v in pairs(char) do
            local v = tonumber(v) or v
            if v ~= 0 then
                local suc, _ = pcall(statBonus[k], v)
                if suc then
                    print(k.."보너스 적용")
                end
            end
        end
        
        --stat을 정수화하고 0~10사이에 있도록 제한
        for k ,v in pairs(stat) do
           stat[k] = math.min(math.max(math.floor(v),0),10)
        end
        stateToVar(triggerId, char, "target") --대상 캐릭터 로어북을 챗변수에 저장
        setState(triggerId, "stat", stat) --계산된 stat를 state에 저장

        --챗변수를 위한 사전처리
        local stat_c = "{"
        for k, v in pairs(stat) do
            stat_c = stat_c .. '"'..k..'":"'..v..'",'
        end
        stat_c = string.gsub(stat_c, ",$", "}")-- 마지막 쉼표 대신 중괄호 닫기
        setChatVar(triggerId, "stat", stat_c) --가공된 stat을 챗변수에 저장
        --state와 chatVar를 둘다 갱신해줘야 cbs랑 lua가 다 잘 작동할 수 있음. 개귀찮..
end