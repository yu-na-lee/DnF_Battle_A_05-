```mermaid
sequenceDiagram
    autonumber
    actor User as 플레이어(사용자)
    participant UI as Add_Item_UI
    participant Battle as 전투
    participant Player as 플레이어
    participant Inv as 인벤토리
    participant Item as 아이템

    User->>UI: 아이템 정보 입력(id, 명칭, 타입, 가치)
    UI->>Battle: 아이템획득(id, 명칭, 타입, 가치)
    
    %% 1. 플레이어 체크 로직
    Battle->>Player: 플레이어체크(id)
    
    alt 플레이어id 불일치
        Player-->>Battle: false (체크 실패)
        Battle-->>UI: 획득 실패 (플레이어 불일치)
    else 플레이어id 일치 (hero)
        Player-->>Battle: true (체크 성공)
        
        %% 2. 인벤토리 추가 및 용량 확인
        Battle->>Inv: 아이템추가(명칭, 타입, 가치)
        
        alt 인벤토리 용량 가득 참 (10칸)
            Inv-->>Battle: false (추가 불가)
            Battle-->>UI: 획득 실패 (공간 부족)
        else 인벤토리 여유 있음
            
            %% 3. 아이템 생성 (Composition 관계) 및 등급 부여
            Inv->>Item: 아이템 객체 생성(명칭, 타입, 가치)
            Note over Item: 가치에 따라 등급 부여<br>(전설 1000 이상, 희귀 500 이상, 일반 500 미만)
            Item-->>Inv: 생성된 객체 반환
            
            %% 4. 리스트 추가 및 최종 완료
            Inv->>Inv: 아이템리스트에 객체 저장
            Inv-->>Battle: true (추가 성공)
            Battle-->>UI: 아이템 획득 성공 메시지
            UI-->>User: 결과 화면 출력
        end
    end