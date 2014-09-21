module spark_demo

import spark.Spark
import dynamic
import watchers

function main = |args| {
  setPort(8080)
  # first load and compile
  let controller = DynamicObject()

  loadPlugin(
      "plugins/controller.golo" # where
    , "signalsController" # function name
    , controller # mixin
  )

  controller: about() # new method

  # watcher
  watch("plugins", {
    # reload and compile if change
    loadPlugin(
        "plugins/controller.golo" # where
      , "signalsController" # function name
      , controller # mixin
    )
  })


  spark.Spark.get("/api/signals/:signal/:values", |request, response| {
    response: type("application/json")
    return controller: dispatch(request)
  })

}

