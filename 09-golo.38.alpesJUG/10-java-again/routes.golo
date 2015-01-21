module routes

import spark.Spark
import org.k33g.models.Book


function router = {
  println("Defining routes...")

  spark.Spark.get("/hi", |request, response| {

    response: type("application/json")
    return JSON.stringify(DynamicObject(): message("Hi!!!"))

  })

  spark.Spark.get("/allbooks", |request, response| {

    response: type("application/json")
    return JSON.stringify(list[
      Book("A Princess of Mars"): title(),
    	Book("The Gods of Mars"): title(),
    	Book("The Chessmen of Mars"): title()
    ])

  })


}

