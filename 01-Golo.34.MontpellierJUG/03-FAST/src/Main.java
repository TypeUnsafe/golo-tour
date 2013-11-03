import fast.jgolo.KlassLoader;
import fast.routes.Router;

import java.io.File;

import static spark.Spark.externalStaticFileLocation;
import static spark.Spark.setPort;

public class Main {

    public static void main(String[] args) {

        setPort(9999);

	/*===static assets ===*/

        File f = new File("app/public");
        externalStaticFileLocation(f.getAbsolutePath());


    /*===
    déclaration du classloader
    les scripts sont à la racine de app
    ===*/
        final KlassLoader k= new KlassLoader((new File("app")).getAbsolutePath());

    /*=== charger tous les scripts golo ===*/
        k.loadAll();


        Router.k = k;

        try {
            k.module("/routes.golo")
                    .method("routes", Object.class)
                    .run((Object) null);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}

