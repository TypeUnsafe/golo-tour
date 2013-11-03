package fast.routes;

import fast.jgolo.KlassLoader;
import spark.Request;
import spark.Response;
import spark.Route;

import static spark.Spark.*;

public class Router {

    public static KlassLoader k;

    public static void GET(String route, final String script, final String method) {

        get(new Route(route){
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });


    }

    public static void POST(String route, final String script, final String method) {

        post(new Route(route) {
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });
    }

    public static void PUT(String route, final String script, final String method) {

        put(new Route(route) {
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });
    }


    public static void DELETE(String route, final String script, final String method) {

        delete(new Route(route) {
            @Override
            public Object handle(Request request, Response response) {

                Object ret = null;

                try {
                    ret = (Object) k.module(script)
                            .method(method, Object.class, Object.class)
                            .run(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    return ret;
                }

            }
        });
    }

}