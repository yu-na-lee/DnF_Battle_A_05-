```mermaid
classDiagram
    %% Boundary Classes (UI 화면)
    class Create_Character_UI {
        <<boundary>>
    }
    class Attack_Monster_UI {
        <<boundary>>
    }
    class Add_Item_UI {
        <<boundary>>
    }
    class Join_Guild_UI {
        <<boundary>>
    }

    %% Controller / Process Classes
    class 전투 {
        +캐릭터생성(플레이어id: String, 캐릭터명: String, 레벨: int, 직업: String) void
        +몬스터공격(플레이어id: String) void
        +아이템획득(플레이어id: String, 아이템명: String, 아이템타입: String, 아이템가치: int) void
        +길드가입(플레이어id: String, 길드명: String) void
    }

    class 플레이어 {
        +플레이어체크(플레이어id: String) boolean
    }

    %% Core Entities & Composite Objects
    class 캐릭터 {
        <<abstract>>
        -캐릭터명: String
        -레벨: int
        -HP: int
        -공격력: int
        -인벤토리멤버: 인벤토리
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

    class 인벤토리 {
        -아이템리스트: List
        -최대용량: int = 10
        +아이템추가(명칭: String, 타입: String, 가치: int) boolean
    }

    class 아이템 {
        -아이템명: String
        -타입: String
        -가치: int
        -등급: String
    }

    class 길드 {
        -길드명: String
        -캐릭터리스트: List
        -최대인원: int = 5
        +캐릭터가입(가입캐릭터: 캐릭터) boolean
    }

    %% Relationships (상속)
    전사 --|> 캐릭터 : 상속 (extends)
    마법사 --|> 캐릭터 : 상속 (extends)
    
    %% 복합객체 관계
    캐릭터 *-- 인벤토리 : Composition
    인벤토리 "1" *-- "N" 아이템 : Composition_1_N
    길드 "1" o-- "N" 캐릭터 : Aggregation_1_N

    %% 시스템 의존성 및 흐름 관계
    Create_Character_UI ..> 전투 : 사용 (Dependency)
    Attack_Monster_UI ..> 전투 : 사용 (Dependency)
    Add_Item_UI ..> 전투 : 사용 (Dependency)
    Join_Guild_UI ..> 전투 : 사용 (Dependency)

    전투 ..> 플레이어 : 플레이어체크 및 ID 조회 요청 (Dependency)
    전투 ..> 캐릭터 : 제어 및 대상
    전투 ..> 인벤토리 : 아이템 추가/조회 요청 (Dependency)
    전투 ..> 길드 : 캐릭터 가입 요청 (Dependency)