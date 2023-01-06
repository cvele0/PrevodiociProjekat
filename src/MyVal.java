public class MyVal {
  public static final int _bool = 0;
  public static final int _int = 2;
  public static final int _char = 1;
  public static final int _real = 3;

  public String name;
  public int type = 0;
  public Object value;
  public int defined = -1, line;

  public MyVal(String name, Object value, int line) {
    this.name = name;
    this.value = value;
    this.line = line;
  }

  public MyVal() {}
}
