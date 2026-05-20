```mermaid
sequenceDiagram
    autonumber
    actor 플_Actor as 플레이어 (Actor)
    participant 전 as 전투
    participant 플 as 플레이어
    participant 캐 as 캐릭터 (전사/마법사)

    플_Actor->>+전: 몬스터공격 요청 (플레이어id, 캐릭터명)
    전->>+플: 플레이어체크(플레이어id:String) 호출
    플-->>-전: 체크 결과 반환 (boolean)

    alt 체크 결과 == true (인증 성공)
        
        alt 직업 == 전사
            전->>+캐: 스킬발동() 호출
            Note over 캐: "검 휘두르기" 수행
            %% 반환 값에 계산식을 정확히 명시!
            캐-->>-전: 스킬명, 데미지 반환 (데미지 = 공격력 × 1.5)
        else 직업 == 마법사
            전->>+캐: 스킬발동() 호출
            Note over 캐: "파이어볼" 수행
            %% 반환 값에 계산식을 정확히 명시!
            캐-->>-전: 스킬명, 데미지 반환 (데미지 = 공격력 × 2.0)
        end
        
        alt 데미지 >= 200
            Note over 전: 등급 = "S급 공격"
        else 데미지 >= 100
            Note over 전: 등급 = "A급 공격"
        else 데미지 < 100
            Note over 전: 등급 = "B급 공격"
        end
        
        전-->>플_Actor: 최종 스킬 처리 결과 및 등급 출력
        
    else 체크 결과 == false (인증 실패)
        전-->>-플_Actor: "플레이어 인증 실패" 메시지 출력
    end