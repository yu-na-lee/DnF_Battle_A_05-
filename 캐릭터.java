package rpg;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int HP;
    protected int 공격력;
    protected String 마지막스킬명 = "";
    protected double 마지막데미지 = 0;

    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int getHP() { return HP; }
    public int get공격력() { return 공격력; }
    public String get마지막스킬명() { return 마지막스킬명; }
    public double get마지막데미지() { return 마지막데미지; }

    public abstract void 스킬발동();
}
