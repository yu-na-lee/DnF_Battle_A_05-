```mermaid
classDiagram
    %% Boundary Classes
    class Create_Character_UI {
        <<boundary>>
    }
    class Attack_Monster_UI {
        <<boundary>>
    }

    %% Controller / Process Classes
    class 전투 {
        +캐릭터생성() void
        +몬스터공격() void
    }

    class 플레이어 {
        +플레이어체크() boolean
    }

    %% Core Entities
    class 캐릭터 {
        <<abstract>>
        -String 캐릭터명
        -int 레벨
        -int HP
        -int 공격력
        +스킬발동()* void
    }

    class 전사 {
        +스킬발동() void
        +검휘두르기() void
    }

    class 마법사 {
        +스킬발동() void
        +파이어볼() void
    }

    %% Relationships Based on Use Case Include & Structure
    전사 --|> 캐릭터 : 상속 (extends)
    마법사 --|> 캐릭터 : 상속 (extends)
    
    %% UI가 전투 컨트롤러를 호출
    Create_Character_UI ..> 전투 : 사용 (Dependency)
    Attack_Monster_UI ..> 전투 : 사용 (Dependency)

    %% [수정 포인트] 전투 기능 수행 시 플레이어 체크(Include 관계 반영)
    전투 ..> 플레이어 : 플레이어체크 요청 (Dependency)
    전투 ..> 캐릭터 : 생성 및 전투 대상 (Dependency)