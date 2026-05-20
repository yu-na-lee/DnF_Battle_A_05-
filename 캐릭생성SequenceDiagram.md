```mermaid
sequenceDiagram
    autonumber
    actor 유저 as 플레이어(유저)
    participant UI as <<boundary>><br/>Create_Character_UI
    participant 전투 as 전투
    participant 플레이어 as 플레이어
    participant 전사 as 전사
    participant 마법사 as 마법사

    %% 플레이어가 모든 정보를 한 번에 입력하여 요청
    유저->>UI: 캐릭터 생성 요청 (플레이어id, 캐릭터명, 레벨, 직업)
    activate UI
    
    UI->>전투: 캐릭터 생성 및 검증 요청 (플레이어id, 캐릭터명, 레벨, 직업)
    activate 전투
    
    %% 플레이어 클래스에서 플레이어 ID 검증
    전투->>플레이어: 플레이어 ID 조회(플레이어id)
    activate 플레이어
    Note over 전투,플레이어: 플레이어 클래스에서 해당 ID가 존재하고<br/>"hero"인지 확인
    플레이어-->>전투: 조회 결과 반환 (Boolean 또는 유저 데이터)
    deactivate 플레이어
    
    %% 검증 결과에 따른 분기 처리
    alt [검증 실패] 존재하지 않거나 "hero"가 아님
        전투-->>UI: 검증 실패 (권한 없음)
        UI-->>유저: "올바른 플레이어가 아닙니다." (프로세스 종료)
        
    else [검증 성공] 플레이어id == "hero"
        %% 직업별 생성 분기 바로 진입
        alt 직업 == "전사"
            전투->>전사: 객체 생성 및 능력치 설정<br/>(캐릭터명, 레벨)
            activate 전사
            Note over 전사: HP = 레벨 x 100<br/>공격력 = 레벨 x 15
            전사-->>전투: 전사 캐릭터 객체 반환
            deactivate 전사
        else 직업 == "마법사"
            전투->>마법사: 객체 생성 및 능력치 설정<br/>(캐릭터명, 레벨)
            activate 마법사
            Note over 마법사: HP = 레벨 x 60<br/>공격력 = 레벨 x 25
            마법사-->>전투: 마법사 캐릭터 객체 반환
            deactivate 마법사
        end
        
        전투-->>UI: 캐릭터 생성 완료 통보
        deactivate 전투
        UI-->>유저: 캐릭터 생성 성공 메시지 출력
        deactivate UI
    end