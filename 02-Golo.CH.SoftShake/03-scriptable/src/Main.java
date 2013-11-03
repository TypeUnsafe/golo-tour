import fr.insalyon.citi.golo.compiler.GoloCompilationException;
import golo.tools.ScriptsLoader;

import java.io.File;

public class Main {

    public static void main(String[] args) throws Exception {
        String appDirectory = "app";



        /* Instance of a golo script loader */
        final ScriptsLoader scriptsLoader = new ScriptsLoader((new File(appDirectory)).getAbsolutePath());

        /* load embedded golo resources*/
        scriptsLoader.loadGoloResource("golo/resources/","helper.golo");

        scriptsLoader.loadGoloResource("golo/resources/","redis.golo");

        /* Load all external golo scripts (in app directory) */
        scriptsLoader.loadAll();


        /* run main() in app/main.golo */
        try {
            scriptsLoader.module("/main.golo")
                    .method("main", Object.class)
                    .run((Object) null);
        } catch (GoloCompilationException g) {
            System.out.println(g.getProblems());
        } catch (Exception e) {
            e.printStackTrace();
        }


        /* run terminate() in app/terminate.golo */
        Runtime.getRuntime().addShutdownHook(new Thread(){
            public void run() {
                try {
                    scriptsLoader.module("/terminate.golo")
                            .method("terminate", Object.class)
                            .run((Object) null);
                } catch (GoloCompilationException g) {
                    System.out.println(g.getProblems());
                }  catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });



    }

}
