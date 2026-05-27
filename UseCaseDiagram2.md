```mermaid
graph LR
    %% 액터(Actor) 정의
    Player(["👤 플레이어"])

    %% 유스케이스(Use Cases) 정의
    UC1([캐릭터생성])
    UC2([몬스터공격])
    UC3([아이템획득])
    UC4([길드가입])
    UC5([플레이어체크])

    %% 플레이어와 주요 기능 연결 (실선)
    Player --- UC1
    Player --- UC2
    Player --- UC3
    Player --- UC4

       %% 주요 기능과 플레이어체크 간의 포함 관계 (점선 화살표)
    UC1 -. "&lt&ltinclude&gt&gt" .-> UC5
    UC2 -. "&lt&ltinclude&gt&gt" .-> UC5
    UC3 -. "&lt&ltinclude&gt&gt" .-> UC5
    UC4 -. "&lt&ltinclude&gt&gt" .-> UC5