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

function main = |args| {

  externalStaticFileLocation(File("."):getCanonicalPath() + "/public") # spark.Spark.externalStaticFileLocation
  setPort(8888) # spark.Spark.setPort

  let Route = Adapter(): extends("spark.Route")
    :implements(
      methods()
        :handle(|this, request, response| {
          return toJsonString(map[["message","Hello Golo!"]])
        })
    )

  get(Route:make():newInstance("/hello")) # spark.Spark.get()


}