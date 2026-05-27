package rpg;

public class 전투 {
    private 캐릭터 생성된캐릭터;
    private String 마지막결과메시지 = "";

    public String get마지막결과메시지() {
        return 마지막결과메시지;
    }

    public void 캐릭터생성(String 플레이어id, String 캐릭터명, int 레벨, String 직업) {
        플레이어 플 = new 플레이어();

        Object 조회결과 = 플.플레이어ID조회(플레이어id);
        if (Boolean.FALSE.equals(조회결과)) {
            마지막결과메시지 = "올바른 플레이어가 아닙니다.";
            return;
        }

        if ("전사".equals(직업)) {
            생성된캐릭터 = new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            생성된캐릭터 = new 마법사(캐릭터명, 레벨);
        } else {
            마지막결과메시지 = "올바르지 않은 직업입니다.";
            return;
        }

        마지막결과메시지 = "캐릭터 생성 성공! [ " + 생성된캐릭터.get캐릭터명() + " / " + 직업 + " / Lv." + 생성된캐릭터.get레벨()
                + " / HP: " + 생성된캐릭터.getHP() + " / 공격력: " + 생성된캐릭터.get공격력() + " ]";
    }

    public void 몬스터공격(String 플레이어id) {
        플레이어 플 = new 플레이어();

        if (!플.플레이어체크(플레이어id)) {
            마지막결과메시지 = "플레이어 인증 실패";
            return;
        }

        if (생성된캐릭터 == null) {
            마지막결과메시지 = "먼저 캐릭터를 생성해주세요.";
            return;
        }

        if (생성된캐릭터 instanceof 전사) {
            생성된캐릭터.스킬발동();
        } else if (생성된캐릭터 instanceof 마법사) {
            생성된캐릭터.스킬발동();
        } else {
            마지막결과메시지 = "전사 또는 마법사 캐릭터가 아닙니다.";
            return;
        }

        String 스킬명 = 생성된캐릭터.get마지막스킬명();
        double 데미지 = 생성된캐릭터.get마지막데미지();

        String 등급;
        if (데미지 >= 200) {
            등급 = "S급 공격";
        } else if (데미지 >= 100) {
            등급 = "A급 공격";
        } else {
            등급 = "B급 공격";
        }

        마지막결과메시지 = "스킬 발동: " + 스킬명 + "\n가한 데미지: " + 데미지 + "\n결과: " + 등급;
    }
}
