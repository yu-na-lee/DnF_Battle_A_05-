```mermaid
sequenceDiagram
    autonumber
    actor 플_Actor as 플레이어 (Actor)
    participant UI as <<boundary>><br/>Join_Guild_UI
    participant 컨트롤러 as : 전투
    participant 플_엔티티 as : 플레이어
    participant 길드 as 기존길드 : 길드
    participant 목록 as 캐릭터리스트 : List

    플_Actor->>+UI: 길드가입 정보 입력 (플레이어id, 길드명)
    UI->>+컨트롤러: 길드가입(플레이어id: String, 길드명: String)
    
    %% 1. 필수 조건: 플레이어체크 수행
    컨트롤러->>+플_엔티티: 플레이어체크(플레이어id: String)
    플_엔티티-->>-컨트롤러: 체크 결과 반환 (boolean)
    
    alt 체크 결과 == true (인증 성공)
        %% 2. 집단화(Aggregation) 관계인 기존 길드 객체의 행위 호출
        컨트롤러->>+길드: 캐릭터가입(가입캐릭터: 캐릭터)
        
        %% 3. 제약 조건: 길드 정원 최대 5명 검증 (속성 활용)
        Note over 길드: 캐릭터리스트.size()와<br/>최대인원(5) 비교 검증
        
        alt 캐릭터리스트.size() < 5 (가입 가능)
            %% StarUML 핵심 포인트: 내부 List 컬렉션에 객체를 추가하는 메시지 명시
            길드->>+목록: add(가입캐릭터: 캐릭터)
            목록-->>-길드: 결과 반환 (boolean)
            
            길드-->>컨트롤러: 가입 성공 반환 (boolean)
            Note over 컨트롤러: 결과 메시지 세팅:<br/>"길드 가입 성공!"
            
        else 캐릭터리스트.size() >= 5 (정원 초과로 가입 불가)
            길드-->>-컨트롤러: 가입 실패 반환 (boolean)
            Note over 컨트롤러: 결과 메시지 세팅:<br/>"길드 정원이 가득 찼습니다."
        end
        
    else 체크 결과 == false (인증 실패)
        Note over 컨트롤러: 결과 메시지 세팅:<br/>"올바른 플레이어가 아닙니다."
    end
    
    컨트롤러-->>UI: 처리 결과 메시지 전달
    deactivate 컨트롤러
    UI-->>-플_Actor: 결과 화면 출력 (index.jsp)