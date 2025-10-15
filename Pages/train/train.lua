[train/1/애무 | {{#when::애무계::vis::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    local cat = "애무계"
    local s, tgl = pcall(getChatVar, triggerId, cat)
    if s and tgl ~= "null" then tgl = math.abs(tonumber(tgl)-1)
    else tgl = 1
    end
    setChatVar(triggerId, cat, tgl)
end!!

[train/2/도구 | {{#when::도구계::vis::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    local cat = "도구계"
    local s, tgl = pcall(getChatVar, triggerId, cat)
    if s and tgl ~= "null" then tgl = math.abs(tonumber(tgl)-1)
    else tgl = 1
    end
    setChatVar(triggerId, cat, tgl)
end!!

[train/3/음부 | {{#when::V계::vis::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    local cat = "V계"
    local s, tgl = pcall(getChatVar, triggerId, cat)
    if s and tgl ~= "null" then tgl = math.abs(tonumber(tgl)-1)
    else tgl = 1
    end
    setChatVar(triggerId, cat, tgl)
end!!

[train/4/애널 | {{#when::A계::vis::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    local cat = "A계"
    local s, tgl = pcall(getChatVar, triggerId, cat)
    if s and tgl ~= "null" then tgl = math.abs(tonumber(tgl)-1)
    else tgl = 1
    end
    setChatVar(triggerId, cat, tgl)
end!!

[train/5/봉사 | {{#when::봉사계::vis::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    local cat = "봉사계"
    local s, tgl = pcall(getChatVar, triggerId, cat)
    if s and tgl ~= "null" then tgl = math.abs(tonumber(tgl)-1)
    else tgl = 1
    end
    setChatVar(triggerId, cat, tgl)
end!!

[train/9/하드 | {{#when::하드계::vis::1}}ON{{:else}}OFF{{/when}}] function(triggerId)
    local cat = "하드계"
    local s, tgl = pcall(getChatVar, triggerId, cat)
    if s and tgl ~= "null" then tgl = math.abs(tonumber(tgl)-1)
    else tgl = 1
    end
    setChatVar(triggerId, cat, tgl)
end!!

[train/--/{{#when::애무계::vis::1}}--애무계--{{/when}}]function end!!

[train/11/{{#when::{{getVar::애무계}}::is::1}}가만 지켜본다{{/when}}] function(triggerId)
    local train = "가만 지켜본다"
end!!

[train/12/{{#when::{{getVar::애무계}}::is::1}}대화한다{{/when}}] function(triggerId)
    local train = "회화한다"
end!!

[train/13/{{#when::{{getVar::애무계}}::is::1}}애무{{/when}}] function(triggerId)
    local target = getState(triggerId, "target")
    local dc = 5 --조교의 난이도. 높을수록 성공확률 낮음
    local costHP = 50
    local costSP = 100
    local dcBonus = 0 --조교 전용 보너스 요소가 있을 수 있음. 높을수록 난이도 상승. 음수면 난이도 감소
   
    --LLM에 전달할 조교 커맨드
    local command =  "<br>{{user}}는 "..target['이름'] .."을 어루만진다."
    local orgasm_t, orgasm_u = sysFunction(triggerId, "trainProcess.sys", dc, costHP, costSP, command)

    target = getState(triggerId, "target") --trainProcess에서 처리된 target의 state로 갱신
    if orgasm_t then
        target["절정경험"] = target["절정경험"] + 1
    end
    --[[ 유저의 절정처리 미구현
    if orgasm_u then
        user["절정경험"] = user["절정경험"] + 1
    end]]

    --조교간에 변경된 유저 또는 대상의 정보(hp, sp 절정경험 등)은 state와 챗변수에 쌓아뒀다가 조교 종료시에 로어북으로 반영.
    setState(triggerId, "target", target)
    stateToVar(triggerId, "target", target)
    
end!!

[train/14/{{#when::{{getVar::애무계}}::is::1}}커널링구스{{/when}}] function(triggerId)
    local train = "커널링구스"
end!!

[train/15/{{#when::{{getVar::애무계}}::is::1}}애널애무{{/when}}] function(triggerId)
    local train = "애널애무"
end!!

[train/16/{{#when::{{getVar::애무계}}::is::1}}자위{{/when}}] function(triggerId)
    local train = "자위"
end!!

[train/17/{{#when::{{getVar::애무계}}::is::1}}가슴 애무{{/when}}] function(triggerId)
    local train = "가슴애무"
end!!

[train/18/{{#when::{{getVar::애무계}}::is::1}}키스{{/when}}] function(triggerId)
    local train = "키스"
end!!

[train/19/{{#when::{{getVar::애무계}}::is::1}}조개벌리기{{/when}}] function(triggerId)
    local train = "보지 벌리기"
end!!

[train/110/{{#when::{{getVar::애무계}}::is::1}}손가락 넣기{{/when}}] function(triggerId)
    local train = "손가락 넣기"
end!!

[train/111/{{#when::{{getVar::애무계}}::is::1}}애널 핥기{{/when}}] function(triggerId)
    local train = "애널 핥기"
end!!

[train/--/{{#when::도구계::vis::1}}--도구계--{{/when}}]function end!!

[train/21/{{#when::{{getVar::도구계}}::is::1}}진동하는보석{{/when}}] function(triggerId)
    local train = "진동하는 보석"
end!!

[train/22/{{#when::{{getVar::도구계}}::is::1}}꿀단지웜{{/when}}] function(triggerId)
    local train = "꿀단지웜"
end!!

[train/23/{{#when::{{getVar::도구계}}::is::1}}진동지팡이{{/when}}] function(triggerId)
    local train = "진동 지팡이"
end!!

[train/24/{{#when::{{getVar::도구계}}::is::1}}애널웜{{/when}}] function(triggerId)
    local train = "애널웜"
end!!

[train/25/{{#when::{{getVar::도구계}}::is::1}}클리캡{{/when}}] function(triggerId)
    local train = "클리캡"
end!!

[train/26/{{#when::{{getVar::도구계}}::is::1}}유두캡{{/when}}] function(triggerId)
    local train = "유두캡"
end!!

[train/27/{{#when::{{getVar::도구계}}::is::1}}착유기{{/when}}] function(triggerId)
    local train = "착유기"
end!!

[train/28/{{#when::{{getVar::도구계}}::is::1}}오나홀{{/when}}] function(triggerId)
    --활성화 조건에 자지가 있다는 조건 추가할 것
    local train = "오나홀"
end!!

[train/29/{{#when::{{getVar::도구계}}::is::1}}애널비즈{{/when}}] function(triggerId)
    local train = "애널비즈"
end!!

[train/210/{{#when::{{getVar::도구계}}::is::1}}아이마스크{{/when}}] function(triggerId)
    local train = "아이마스크"
end!!

[train/211/{{#when::{{getVar::도구계}}::is::1}}볼개그{{/when}}] function(triggerId)
    local train = "볼개그"
end!!

[train/--/{{#when::V계::vis::1}}--삽입계--{{/when}}]function end!!

[train/31/{{#when::{{getVar::V계}}::is::1}}정상위{{/when}}] function(triggerId)
    local train = "정상위"
end!!

[train/32/{{#when::{{getVar::V계}}::is::1}}후배위{{/when}}] function(triggerId)
    local train = "후배위"
end!!

[train/33/{{#when::{{getVar::V계}}::is::1}}대면좌위{{/when}}] function(triggerId)
    local train = "대면좌위"
end!!

[train/34/{{#when::{{getVar::V계}}::is::1}}배면좌위{{/when}}] function(triggerId)
    local train = "배면좌위"
end!!

[train/35/{{#when::{{getVar::V계}}::is::1}}기승위{{/when}}] function(triggerId)
    local train = "기승위"
end!!

[train/--/{{#when::A계::vis::1}}--애널계--{{/when}}]function end!!

[train/41/{{#when::{{getVar::A계}}::is::1}}정상위애널{{/when}}] function(triggerId)
    local train = "정상위애널"
end!!

[train/42/{{#when::{{getVar::A계}}::is::1}}후배위애널{{/when}}] function(triggerId)
    local train = "후배위애널"
end!!

[train/43/{{#when::{{getVar::A계}}::is::1}}대면좌위애널{{/when}}] function(triggerId)
    local train = "대면좌위애널"
end!!

[train/44/{{#when::{{getVar::A계}}::is::1}}배면좌위애널{{/when}}] function(triggerId)
    local train = "배면좌위애널"
end!!

[train/45/{{#when::{{getVar::A계}}::is::1}}기승위애널{{/when}}] function(triggerId)
    local train = "기승위애널"
end!!

[train/--/{{#when::봉사계::vis::1}}--봉사계--{{/when}}]function end!!

[train/51/{{#when::{{getVar::봉사계}}::is::1}}수음{{/when}}] function(triggerId)
    local train = "수음"
end!!

[train/52/{{#when::{{getVar::봉사계}}::is::1}}펠라치오{{/when}}] function(triggerId)
    local train = "펠라치오"
end!!

[train/53/{{#when::{{getVar::봉사계}}::is::1}}파이즈리{{/when}}] function(triggerId)
    local train = "파이즈리"
end!!

[train/54/{{#when::{{getVar::봉사계}}::is::1}}가랑이 비비기{{/when}}] function(triggerId)
    --본인과 상대 모두 보지가 있을것을 조건에 추가할 것
    local train = "가랑이비비기"
end!!

[train/55/{{#when::{{getVar::봉사계}}::is::1}}풋잡{{/when}}] function(triggerId)
    local train = "풋잡"
end!!

[train/56/{{#when::{{getVar::봉사계}}::is::1}}식스나인{{/when}}] function(triggerId)
    local train = "식스나인"
end!!

[train/57/{{#when::{{getVar::봉사계}}::is::1}}오일 마사지{{/when}}] function(triggerId)
    local train = "오일 마사지"
end!!

[train/58/{{#when::{{getVar::봉사계}}::is::1}}리밍{{/when}}] function(triggerId)
    local train = "리밍"
end!!

[train/--/{{#when::하드계::vis::1}}--하드계--{{/when}}]function end!!

[train/91/{{#when::{{getVar::하드계}}::is::1}}스팽킹{{/when}}] function(triggerId)
    local train = "스팽킹"
end!!

[train/92/{{#when::{{getVar::하드계}}::is::1}}채찍{{/when}}] function(triggerId)
    local train = "채찍"
end!!

[train/93/{{#when::{{getVar::하드계}}::is::1}}유두 바늘{{/when}}] function(triggerId)
    local train = "유두 바늘"
end!!

[train/94/{{#when::{{getVar::하드계}}::is::1}}귀갑묶기{{/when}}] function(triggerId)
    local train = "밧줄"
end!!

[train/95/{{#when::{{getVar::하드계}}::is::1}}관장+플러그{{/when}}] function(triggerId)
    local train = "관장+플러그"
end!!

[train/96/{{#when::{{getVar::하드계}}::is::1}}방뇨{{/when}}] function(triggerId)
    local train = "방뇨"
end!!

[train/97/{{#when::{{getVar::하드계}}::is::1}}음뇨{{/when}}] function(triggerId)
    local train = "음뇨"
end!!

[train/98/{{#when::{{getVar::하드계}}::is::1}}수간플레이{{/when}}] function(triggerId)
    local train = "수간플레이"
end!!

[train/99/{{#when::{{getVar::하드계}}::is::1}}피스트퍽{{/when}}] function(triggerId)
    local train = "피스트퍽"
end!!

[train/910/{{#when::{{getVar::하드계}}::is::1}}애널피스트{{/when}}] function(triggerId)
    local train = "애널피스트"
end!!

[train/911/{{#when::{{getVar::하드계}}::is::1}}양구멍피스트{{/when}}] function(triggerId)
    local train = "양구멍피스트"
end!!

[train/--/ ]function end!!

[train/101/로션] function(triggerId)
    local train = "로션"
end!!

[train/102/미약] function(triggerId)
    local train = "미약"
end!!

[train/103/이뇨제] function(triggerId)
    local train = "이뇨제"
end!!

[train/104/콘돔] function(triggerId)
    local train = "이뇨제"
end!!

[train/105/수정구] function(triggerId)
    local train = "수정구"
end!!

[train/106/야외플레이] function(triggerId)
    local train = "야외플레이"
end!!

[train/199/돌아가기] function(triggerId)
    setState(triggerId, "screen", "main")
end!!