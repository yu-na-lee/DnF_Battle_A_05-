```mermaid
classDiagram
    %% Boundary Classes (UI 화면)
    class Create_Character_UI {
        <<boundary>>
    }
    class Attack_Monster_UI {
        <<boundary>>
    }

    %% Controller / Process Classes 
    class 전투 {
        +캐릭터생성(String 플레이어id, String 캐릭터명, int 레벨, String 직업) void
        +몬스터공격(String 플레이어id) void
    }

    class 플레이어 {
        +플레이어체크(String 플레이어id) boolean
    }

    %% Core Entities (실제 객체 및 자식 클래스)
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

    %% Relationships
    전사 --|> 캐릭터 : 상속 (extends)
    마법사 --|> 캐릭터 : 상속 (extends)
    
    Create_Character_UI ..> 전투 : 사용 (Dependency)
    Attack_Monster_UI ..> 전투 : 사용 (Dependency)

    전투 ..> 플레이어 : 플레이어체크 및 ID 조회 요청 (Dependency)
    전투 ..> 캐릭터 : 생성 및 전투 대상 (Dependency)