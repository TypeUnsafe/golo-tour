import fr.insalyon.citi.golo.compiler.GoloClassLoader;

import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.Method;

public class Main {

  public static void main(String[] args) throws Exception {

    String appDirectory = "app";

    GoloClassLoader classLoader = new GoloClassLoader();
    Class<?> moduleClass = classLoader.load(
        "main.golo"
      , new FileInputStream((new File(appDirectory)).getAbsolutePath()+"/main.golo")
    );
    Method mainGolo = moduleClass.getMethod("main", Object.class);
    mainGolo.invoke(null, (Object) null);

  }

}
