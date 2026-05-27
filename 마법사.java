package rpg;

public class 마법사 extends 캐릭터 {

    public 마법사(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
        this.HP = 레벨 * 60;
        this.공격력 = 레벨 * 25;
    }

    @Override
    public void 스킬발동() {
        파이어볼();
    }

    public void 파이어볼() {
        this.마지막데미지 = this.공격력 * 2.0;
        this.마지막스킬명 = "파이어볼!";
    }
}
