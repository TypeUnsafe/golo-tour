import spark.Request;
import spark.Response;
import spark.Route;

import java.io.File;
import java.util.HashMap;

import static spark.Spark.*;

public class Main {


  public static void main(String[] args) throws Exception {

    externalStaticFileLocation(new File(".").getCanonicalPath() + "/app/public");
    setPort(8888);

    get(new Route("/add/:a/:b") {
      @Override
      public Object handle(Request request, Response response) {
        response.type("application/json");

        Integer a = Integer.parseInt(request.params(":a"));
        Integer b = Integer.parseInt(request.params(":b"));
        final Integer c = a + b;

        HashMap result = new HashMap<String, Integer>() {{
          put("result",c);
        }};

        return json.Json.stringify(json.Json.toJson(result));
      }
    });
  }


}
