module spark

import spark.Spark
import java.io.File

function route = |uri, callback| {
  
  let routeDefinition = map[
    ["extends", "spark.Route"],
    ["implements", map[
      ["handle", |this, request, response| {
          return callback(request, response)
      }]
    ]]
  ]
  return AdapterFabric(): maker(routeDefinition): newInstance(uri)
}

function GET = |uri, callback| {
  return spark.Spark.get(route(uri, callback))
}

function POST = |uri, callback| {
  return spark.Spark.post(route(uri, callback))
}

function port = |port_number| -> setPort(port_number)
