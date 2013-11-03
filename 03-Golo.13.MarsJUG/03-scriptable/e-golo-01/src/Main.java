import com.fasterxml.jackson.databind.JsonNode;
import json.Json;
import spark.Request;
import spark.Response;
import spark.Route;

import java.io.File;
import java.util.LinkedList;
import java.util.List;
import java.util.TreeMap;

import static spark.Spark.*;

public class Main {

  public static List<Object> humansList = new LinkedList<>();

  public static void main(String[] args) throws Exception {

    externalStaticFileLocation(new File(".").getCanonicalPath() + "/app/public");
    setPort(8888);

    //spark.Spark.externalStaticFileLocation();
    //spark.Spark.setPort();

    post(new Route("/humans"){
      @Override
      public Object handle(Request request, Response response) {

        JsonNode node = json.Json.parse(request.body());
        TreeMap<String,Object> fields = Json.fromJson(node,TreeMap.class);
        fields.put("id", java.util.UUID.randomUUID().toString());
        humansList.add(fields);

        return json.Json.stringify(Json.toJson(fields));
      }
    });



    get(new Route("/humans"){
      @Override
      public Object handle(Request request, Response response) {
        return json.Json.stringify(json.Json.toJson(humansList));
      }
    });

  }

}
