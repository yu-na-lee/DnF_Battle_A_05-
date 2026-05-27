package rpg;

public class 플레이어 {
    public boolean 플레이어체크(String 플레이어id) {
        return "hero".equals(플레이어id);
    }

    public Object 플레이어ID조회(String 플레이어id) {
        if (플레이어체크(플레이어id)) {
            return 플레이어id;
        }
        return Boolean.FALSE;
    }
}
