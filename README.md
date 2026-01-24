# RisuMaou 🦹‍♂️

RisuAI 플랫폼에서 동작하는 다크 판타지 캐릭터 조교 시뮬레이션 봇입니다.

> ⚠️ **경고**: 이 프로젝트는 **성인 전용** 콘텐츠를 포함하고 있습니다.

## 📁 프로젝트 구조

```
RisuMaou/
├── DB/                     # 게임 데이터베이스 (JSON 형식)
│   ├── Chars/              # 캐릭터 프리셋 데이터
│   ├── race.db.txt         # 종족 정보 (인간, 엘프, 드워프, 수인)
│   ├── class.db.txt        # 직업 정보 (검사, 기사, 마법사 등)
│   ├── trait.db.txt        # 특성 정의 (성격, 신체특성, 성적취향, 칭호)
│   ├── abl.db.txt          # 어빌리티 정의 (민감도, 순응, 성욕 등)
│   ├── stat.db.txt         # 스탯 정의 (쾌락, 윤활, 저항 등)
│   ├── mark.db.txt         # 각인 정의 (긍정/부정적 각인)
│   ├── train.db.txt        # 조교 커맨드 정의
│   ├── monsters.db.txt     # 몬스터 정보 (100종)
│   ├── Items.db.txt        # 아이템 정의
│   ├── equipments.db.txt   # 장비 정의
│   └── ...
├── Pages/                  # UI 화면 (HTML + Lua)
│   ├── main/               # 메인 화면
│   ├── train/              # 조교 화면
│   ├── chars/              # 캐릭터 정보/목록
│   ├── dictionary/         # 도감/사전
│   ├── Shop/               # 상점
│   ├── config/             # 설정
│   └── disposal/           # 처분/판매
├── Prompts/                # LLM 프롬프트 템플릿
│   ├── system.pt.txt       # 시스템 프롬프트
│   ├── trainLog.pt.txt     # 조교 로그 생성
│   ├── trainResponse.pt.txt# 조교 응답 생성
│   ├── newChar.pt.txt      # 신규 캐릭터 생성
│   ├── charExplain.pt.txt  # 캐릭터 설명 생성
│   └── worlBriefing.pt.txt # 월드 브리핑
├── system/                 # 코어 시스템 파일 (Lua)
│   ├── Script.lua.txt      # 메인 스크립트 (진입점)
│   ├── initVars.sys.txt    # 변수 초기화
│   ├── newChar.sys.txt     # 캐릭터 생성 로직
│   ├── train.sys.txt       # 조교 통합 로직 (액션, 태그매칭, 삽입 등)
│   ├── trainProcess.sys.txt# 조교 프로세스 실행 (LLM 핸들링)
│   ├── customEvent.sys.txt # 커스텀 이벤트 시스템
│   ├── item.sys.txt        # 아이템/상점 시스템
│   ├── ability.sys.txt     # 어빌리티 시스템
│   ├── char.sys.txt        # 캐릭터 관리 시스템
│   └── ...
├── Imgs/                   # 이미지 에셋
├── CBS Guide.md            # CBS(Curly Braced Syntaxes) 가이드
├── LUA Guide.md            # Lua 트리거 가이드
├── customEvent.md          # 커스텀 이벤트 시스템 문서
└── special thnx.txt        # 크레딧
```

## 🎮 주요 기능

### 캐릭터 시스템
- **종족**: 인간, 엘프, 드워프, 수인 (각각 고유 스탯 보정치와 특성)
- **직업**: 검사, 기사, 마법사, 성직자, 도적, 궁수
- **특성(Trait)**: 성격, 신체특성, 성적취향, 칭호 카테고리로 분류

### 조교 시스템
- **stat 시스템**: 쾌락, 윤활, 저항, 기술 등 다양한 스탯
- **abl 시스템**: 민감도, 순응, 성욕 등 레벨업 가능한 어빌리티
- **mark 시스템**: 조교 결과에 따라 부여되는 각인

### 이벤트 시스템
`customEvent.sys.txt` 시스템을 통해 `trait`, `abl`, `mark`, `stat` DB에 정의된 이벤트를 동적으로 실행합니다.

#### 1. 검토 대상 DB
이벤트 발생 시 캐릭터가 보유한 다음 항목들의 `events` 필드를 순회하며 검사합니다:
- **trait.db**: 특성 (성격, 신체특성 등)
- **abl.db**: 어빌리티 (레벨 비례)
- **mark.db**: 각인 (레벨 비례)
- **stat.db**: 상태 (현재 스탯 레벨 비례)

#### 2. 주요 이벤트 목록
| 이벤트명 | 발동 시점 | Context 변수 | 설명 |
|---|---|---|---|
| `onDCCalc` | 조교 성공률(DC) 계산 시 | `dc`, `tags`, `stat`, `category`, `target` | `dc` 값을 수정하여 조교 난이도 조정 |
| `onCostCalc` | 행동 비용(HP/SP) 계산 시 | `costHP`, `costSP`, `tags`, `stat`, `target` | 체력 및 기력 소모량 수정 |
| `onStatEXP` | 스탯 경험치 획득 시 | `statEXP`, `statName`, `tags`, `target`, `allStatEXP` | 경험치 획득량 배율 적용 또는 다른 스탯으로 전환 |
| `onOrgasmCalc` | 절정 게이지 계산 시 | `orgasm` (예상치), `tags` | 절정 게이지 증가량 보정 |

## 🛠️ 기술 스택

- **플랫폼**: [RisuAI](https://risuai.net)
- **스크립팅**: Lua 5.4 (JS 런타임 위에서 실행)
- **템플릿**: CBS (Curly Braced Syntaxes)
- **UI**: HTML + CSS (RisuAI 내장 렌더러)
- **데이터**: JSON 기반 DB 파일

> ⚠️ **HTML/CSS 스타일링 주의사항**
> 리수플랫폼에서는 CSS 클래스명에 자동으로 `risu-x-` 등의 접두사가 붙습니다. 따라서 HTML에서 `class="my-style"`이라고 정의했더라도, CSS에서는 `.x-risu-my-style` (또는 개발자 도구에서 확인된 접두사)로 스타일을 정의해야 적용될 수 있습니다. 반드시 브라우저 개발자 도구(F12)로 실제 적용된 클래스명을 확인하세요.

## 📖 문서

- [CBS Guide.md](CBS%20Guide.md) - RisuAI CBS 문법 완전 가이드 (v166)
- [LUA Guide.md](LUA%20Guide.md) - RisuAI Lua 트리거 가이드 (v166)

## 🙏 크레딧

- Risuai: https://github.com/kwaroran/Risuai

## 📜 라이선스

이 프로젝트는 자체 라이선스를 따릅니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---

# 🤖 코딩 에이전트를 위한 가이드라인

> 이 섹션은 AI 코딩 어시스턴트(Claude, Cursor, Copilot 등)가 이 프로젝트를 수정할 때 참고해야 할 핵심 정보입니다.

## ⚠️ 반드시 지켜야 할 규칙

### 1. DB 키 체계
```
DB 파일: 영어 키 (English Keys)
├── race.db: "human", "elf", "dwarf", "beastkin"
├── class.db: "swordsman", "knight", "mage", ...
├── trait.db: "curious", "cautious", "c_sensitive", ...
├── abl.db: "c_sensibility", "obedience", "desire", ...
└── stat.db, mark.db 등 모두 동일

메모리 내 캐릭터 데이터: 한국어 키 (Korean Keys)
├── char.traits = {"호기심": 1, "C민감": 2, ...}
├── char.abl = {"C민감도": 5, "순응": 3, ...}
└── 기존 CBS/HTML과 호환성 유지
```

**❌ 잘못된 예시:**
```lua
-- DB에서 한국어 키 사용
traitDB["호기심"]  -- 틀림!

-- 캐릭터 데이터에서 영어 키 사용
char.traits["curious"]  -- 틀림!
```

**✅ 올바른 예시:**
```lua
-- DB 접근 (영어 키)
local traitData = traitDB["curious"]
local traitName = traitData.name  -- "호기심"

-- 캐릭터 데이터 접근 (한국어 키)
local hasTraitLevel = char.traits["호기심"]
```

### 2. 파일 확장자 규칙
| 파일 타입 | 확장자 | 설명 |
|----------|--------|------|
| DB 파일 | `.db.txt` | JSON 형식, 주석은 `///` 사용 |
| 페이지 Lua | `.lua.txt` | 화면별 Lua 스크립트 |
| 시스템 Lua | `.sys.txt` | 공용 시스템 함수 |
| HTML 템플릿 | `.html` | CBS 문법 사용 |
| 프롬프트 | `.pt.txt` | LLM 프롬프트 템플릿 |

### 3. 이벤트 시스템 구조
```json
"trait_key": {
    "name": "특성 이름",
    "desc": "설명",
    "category": "성격|신체특성|성적취향|칭호",
    "group": "상호배타 그룹 (선택)",
    "events": {
        "onDCCalc": {
            "hasTags": ["태그1", "태그2"],  // 모두 있어야 발동
            "notTags": ["태그3"],           // 하나라도 있으면 발동 안함
            "func": "dc = dc - 5"           // Lua 코드
        }
    }
}
```

### 4. 태그 시스템
조교 커맨드에 부여되는 태그들:

| 태그 카테고리 | 태그 예시 |
|--------------|----------|
| 신체 부위 | `C`, `B`, `V`, `A`, `M` |
| 삽입 | `insert_V`, `insert_A`, `insert_U`, `insert_M` |
| 행위 유형 | `touch`, `oral`, `service`, `sex` |
| 특수 상대 | `tentacle`, `beast`, `monster` |
| 강도 | `gentle`, `safe`, `pain`, `hard` |
| 기타 | `shame`, `bondage`, `filth`, `tool` |

### 5. HTML 내 CBS 변수 접근
```html
<!-- 변수 표시 -->
{{getvar::char_name}}
{{getvar::char_hp}}

<!-- 조건부 렌더링 -->
{{#when::{{getvar::char_hp}}::>::::0}}
    HP 있음
{{/when}}

<!-- 버튼 (Lua 함수 호출) -->
{{button::버튼텍스트::functionName}}
```

### 6. 상태(state) vs 챗변수(chatVar)
```lua
-- state: 복잡한 객체 저장, 성능 좋음 (권장), CBS에서 __state명 형식으로 접근 가능하나 테이블로 저장된 정보는 {{dict_element}} 또는 {{array_element}}로 호출 불가
setState(triggerId, "chars", charTable)
local chars = getState(triggerId, "chars")

-- chatVar: 단순 문자열, CBS에서 접근 가능
setChatVar(triggerId, "char_name", char.name)
-- HTML에서: {{getvar::char_name}}
```

### 7. 로어북 직접 로딩 (캐싱 없음)
```lua
-- RisuAI 플랫폼 특성상 getLoreBooks 직접 호출이 캐싱보다 빠름
-- 따라서 모든 DB/로어북 접근은 매번 직접 호출
local traitDB = getDB(triggerId, "trait.db")
local content = getLoreBookContent(triggerId, "some.lua")

-- 내부적으로 getLoreBooks(triggerId, lore)[1].content를 직접 호출
-- 캐싱 관련 함수(clearDBCache 등)는 더 이상 존재하지 않음
```

> ⚠️ **중요**: RisuAI 플랫폼 테스트 결과, 전역변수나 state에 캐싱하는 것보다 `getLoreBooks`를 직접 호출하는 것이 **훨씬 빠름**. 불필요한 캐싱 로직을 추가하지 마세요.

### 8. 시스템 파일 패턴 (Dispatcher Pattern)
여러 기능을 포함하는 `.sys` 파일은 확장성을 위해 디스패처 패턴을 사용합니다:
```lua
(function()
    local funcs = {}

    function funcs.funcA(triggerId, ...) ... end
    function funcs.funcB(triggerId, ...) ... end

    return function(triggerId, subFunc, ...)
        if funcs[subFunc] then
            return funcs[subFunc](triggerId, ...)
        end
    end
end)()
```
- `sysFunction(id, "file.sys", "funcA", args...)` 형태로 호출합니다.
- 단일 기능 파일(예: `initVars.sys`)은 이 패턴을 따르지 않습니다.

## 🔧 주요 시스템 파일

| 파일 | 역할 |
|------|------|
| `Script.lua.txt` | 메인 진입점, 전역 함수 정의 |
| `initVars.sys.txt` | 게임 초기화, 변수 설정 |
| `trainProcess.sys.txt` | 조교 핵심 루프 실행 (LLM 요청 등) |
| `train.sys.txt` | 조교 액션, 태그 매칭, 삽입 로직, 후처리 통합 관리 |
| `item.sys.txt` | 아이템 사용, 구매, 소모 관리 |
| `customEvent.sys.txt` | 이벤트 시스템 실행 엔진 |

## 📝 코드 수정 체크리스트

- [ ] DB 파일 수정 시 영어 키 사용 확인
- [ ] 캐릭터 데이터 접근 시 한국어 키 사용 확인
- [ ] 이벤트 추가 시 `customEvent.md` 문서 참조
- [ ] 새 태그 추가 시 기존 태그와 충돌 여부 확인
- [ ] 비동기 함수 `:await()` 사용 규칙 준수
- [ ] CBS 문법 사용 시 `CBS Guide.md` 참조
- [ ] **로어북 캐싱 금지**: 직접 호출이 더 빠름

## 🐛 알려진 제한사항

1. **Lua 성능**: JavaScript 위에서 실행되므로 반복문 최소화 필요
2. **setDescription() 버그**: 현재 작동하지 않음 (RisuAI 소스코드 버그)
3. **HTML 내 setvar 불가**: CBS 변수 설정은 Lua에서만 가능
4. **os.clock() 제한**: 35분 후 오버플로우 발생
5. **HTML 들여쓰기 금지**: Lua 스크립트 내에서 HTML 문자열 생성 시, **들여쓰기(Tab/Space)**를 포함하면 RisuAI 플랫폼에서 파싱 에러가 발생할 수 있습니다.

## 📚 참고 자료

- [RisuAI 공식 사이트](https://risuai.net)
- [CBS Guide.md](CBS%20Guide.md) - CBS 문법 완전 가이드
- [LUA Guide.md](LUA%20Guide.md) - Lua 트리거 가이드
- [customEvent.md](customEvent.md) - 이벤트 시스템 문서
