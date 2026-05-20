package rpg;

public class 전사 extends 캐릭터 {
    
    public 전사(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
        this.HP = 레벨 * 100;
        this.공격력 = 레벨 * 15;
    }

    @Override
    public Object[] 스킬발동() {
        return 검휘두르기();
    }

    public Object[] 검휘두르기() {
        // 전사 데미지 = 공격력 x 1.5
        double 데미지 = this.공격력 * 1.5;
        return new Object[]{"검 휘두르기!", 데미지};
    }
}