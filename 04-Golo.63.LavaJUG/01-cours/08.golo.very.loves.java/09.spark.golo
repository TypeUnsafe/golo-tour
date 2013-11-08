module spark_java

import org.k33g.alien.adapters

import com.fasterxml.jackson.databind.ObjectMapper

import spark.Request
import spark.Response
import spark.Route

import spark.Spark

import java.io.File

function toJsonString = |data| {
  let mapper = ObjectMapper()
  return mapper:writeValueAsString(data)
}

function route = |uri, method| {

  let conf = map[
    ["extends", "spark.Route"],
    ["implements", map[
      ["handle", |this, request, response| {
        return method(request, response)
      }]         
    ]]
  ]
  let Route = AdapterFabric(): maker(conf): newInstance(uri)

  return Route

}

function GET = |uri, method| {
  return spark.Spark.get(route(uri, method))
}

function POST = |uri, method| {
  return spark.Spark.post(route(uri, method))
}

function main = |args| {

  externalStaticFileLocation(File("."):getCanonicalPath() + "/public") # spark.Spark.externalStaticFileLocation
  setPort(8888) # spark.Spark.setPort

  GET("/hello", |request, response| {
    return toJsonString(map[["message","Hello Golo!"]])
  }) 

  GET("/salut", |request, response| {
      return toJsonString(map[["message","Salut Golo!"]])
  })

  GET("/test/:id", |request, response| {
      return toJsonString(map[["message", request:params(":id"):toString()]])
  })

  POST("/bob", |request, response| {
    response:type("application/json")
    let resp = request: body()
    println(resp)
    return toJsonString(resp)
  })

}

  #let Route = Adapter(): extends("spark.Route")
  #  :implements(
  #    methods()
  #      :handle(|this, request, response| {
  #        return method(request, response)
  #      })
  #  )

  #return Route:make():newInstance(uri)



