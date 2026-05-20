package rpg;

public class 마법사 extends 캐릭터 {
    
    public 마법사(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
        this.HP = 레벨 * 60;
        this.공격력 = 레벨 * 25;
    }

    @Override
    public Object[] 스킬발동() {
        return 파이어볼();
    }

    public Object[] 파이어볼() {
        // 마법사 데미지 = 공격력 x 2.0
        double 데미지 = this.공격력 * 2.0;
        return new Object[]{"파이어볼!", 데미지};
    }
}