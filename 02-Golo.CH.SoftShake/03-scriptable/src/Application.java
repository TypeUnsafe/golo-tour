import spark.Request;
import spark.Response;
import spark.Route;

import java.lang.invoke.MethodHandle;
import java.util.HashMap;

import static spark.Spark.*;

public class Application {

    public static HashMap<String,Object> memory = new HashMap<>();

    /*===static assets ===*/
    public void staticFileLocation(String path) {
        externalStaticFileLocation(path);
    }
    /*===http port ===*/
    public void port(int port) {
        setPort(port);
    }

    public void GET(String path, final MethodHandle something) {

        get(new Route(path) {
            @Override
            public Object handle(Request request, Response response) {
                Object ret = null;
                try {
                    ret = something.invoke(request, response);
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                } finally {
                    return ret;
                }
            }
        });

    }

    public void POST(String path, final MethodHandle something) {

        post(new Route(path) {
            @Override
            public Object handle(Request request, Response response) {
                Object ret = null;
                try {
                    ret = something.invoke(request, response);
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                } finally {
                    return ret;
                }
            }
        });

    }

    public void PUT(String path, final MethodHandle something) {

        put(new Route(path) {
            @Override
            public Object handle(Request request, Response response) {
                Object ret = null;
                try {
                    ret = something.invoke(request, response);
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                } finally {
                    return ret;
                }
            }
        });

    }

    public void DELETE(String path, final MethodHandle something) {

        delete(new Route(path) {
            @Override
            public Object handle(Request request, Response response) {
                Object ret = null;
                try {
                    ret = something.invoke(request, response);
                } catch (Throwable throwable) {
                    throwable.printStackTrace();
                } finally {
                    return ret;
                }
            }
        });

    }
}
