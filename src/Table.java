import java.util.ArrayList;
import java.util.HashMap;

public class Table {
  private static Table instance = null;
  public HashMap<String, ArrayList<MyVal>> table = new HashMap<>();

  private Table() {}

  public static Table getInstance() {
    if (instance == null)
      instance = new Table();

    return instance;
  }

  public Boolean exitBlock(int opc) {
    Boolean redef = false;

    for (String i: table.keySet()) {
      ArrayList<MyVal> b = table.get(i);
      int br = 0;

      while (b.size() > 0 && b.get(b.size() - 1).line >= opc) {
        b.remove(b.size() - 1);
        ++br;
      }

      if (br > 1) redef = true;
    }

    return redef;
  }

  public void declare(MyVal var) {
    if (var.name == null) return;

    if (table.containsKey(var.name))
      (table.get(var.name)).add(var);
    else {
      table.put(var.name, new ArrayList<>());
      (table.get(var.name)).add(var);
    }
  }

  public MyVal getVar(String name) {
    if (name == null) return null;

    if (table.containsKey(name)) {
      ArrayList<MyVal> b = table.get(name);
      if (b.isEmpty()) return null;
      return b.get(b.size() - 1);
    }
    else return null;
  }
}
