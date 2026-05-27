package rpg;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트 = new ArrayList<>();
    private int 최대용량 = 10;

    public boolean 아이템추가(String 아이템명, String 타입, int 가치) {
        if (아이템리스트.size() >= 최대용량) {
            return false;
        }
        아이템 뉴아이템 = new 아이템(아이템명, 타입, 가치);
        return 아이템리스트.add(뉴아이템);
    }

    public boolean 아이템추가(아이템 뉴아이템) {
        if (아이템리스트.size() >= 최대용량) {
            return false;
        }
        return 아이템리스트.add(뉴아이템);
    }

    public int get현재개수() { return 아이템리스트.size(); }
    public int get최대용량() { return 최대용량; }

    public 아이템 get마지막아이템() {
        if (아이템리스트.isEmpty()) {
            return null;
        }
        return 아이템리스트.get(아이템리스트.size() - 1);
    }
}
