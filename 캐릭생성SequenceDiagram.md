```mermaid
sequenceDiagram
    autonumber
    actor 플레이어 as 플레이어
    participant UI as <<boundary>><br/>Create_Character_UI
    participant 생성 as 캐릭터생성
    participant DB as [DB] Player Table
    participant 전사 as 전사
    participant 마법사 as 마법사

    %% [1단계] 플레이어 ID 검증 단계
    플레이어->>UI: 캐릭터 생성 진입 요청 (플레이어id)
    activate UI
    
    UI->>생성: 플레이어 검증 요청(플레이어id)
    activate 생성
    
    %% DB에서 플레이어 ID 정보를 조회/검증하는 흐름
    생성->>DB: 플레이어 ID 조회(플레이어id)
    activate DB
    Note over 생성,DB: DB에서 해당 ID가 존재하고<br/>"hero"인지 확인
    DB-->>생성: 조회 결과 반환 (Boolean 또는 유저 데이터)
    deactivate DB
    
    alt 검증 실패 (존재하지 않거나 "hero"가 아님)
        생성-->>UI: 검증 실패 (권한 없음)
        UI-->>플레이어: "올바른 플레이어가 아닙니다." (프로세스 종료)
        
    else 검증 성공 (플레이어id == "hero")
        생성-->>UI: 검증 성공 (캐릭터 생성 가능)
        deactivate 생성
        UI-->>플레이어: 캐릭터 정보 입력 화면 표시 (캐릭터명, 레벨, 직업)
        deactivate UI
        
        %% [2단계] 캐릭터 정보 입력 및 실제 생성 단계
        플레이어->>UI: 캐릭터 정보 입력 완료 (캐릭터명, 레벨, 직업)
        activate UI
        UI->>생성: 캐릭터 생성 요청(캐릭터명, 레벨, 직업)
        activate 생성
        
        %% 직업별 생성 분기
        alt 직업 == "전사"
            생성->>전사: 객체 생성 및 능력치 설정<br/>(캐릭터명, 레벨)
            activate 전사
            Note over 전사: HP = 레벨 x 100<br/>공격력 = 레벨 x 15
            전사-->>생성: 전사 캐릭터 객체 반환
            deactivate 전사
        else 직업 == "마법사"
            생성->>마법사: 객체 생성 및 능력치 설정<br/>(캐릭터명, 레벨)
            activate 마법사
            Note over 마법사: HP = 레벨 x 60<br/>공격력 = 레벨 x 25
            마법사-->>생성: 마법사 캐릭터 객체 반환
            deactivate 마법사
        end
        
        생성-->>UI: 캐릭터 생성 완료 통보
        deactivate 생성
        UI-->>플레이어: 캐릭터 생성 성공 메시지 출력
        deactivate UI
    end