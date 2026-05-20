package rpg;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected int 공격력;

    // Getter
    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int getHP() { return HP; }
    public int get공격력() { return 공격력; }

    // 스킬명과 데미지를 배열 형태로 반환 [String, Double]
    public abstract Object[] 스킬발동();
}