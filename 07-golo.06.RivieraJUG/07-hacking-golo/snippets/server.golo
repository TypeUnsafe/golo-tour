module samples.WebServer

import java.lang
import java.net.InetSocketAddress
import com.sun.net.httpserver
import com.sun.net.httpserver.HttpServer

function GoloHttpServer = |host, port, whatToDo| {

  let dynServer = DynamicObject()

  let server = HttpServer.create(InetSocketAddress(host, port), 0)
  
  server: createContext("/", |exchange| {
    let headers = exchange: getResponseHeaders()
    #headers: set("Content-Type", "text/plain")
    headers: set("Content-Type", "application/json")

    let httpExchange = DynamicObject()
      : response("")
      : code(200)
      : uri(exchange: getRequestURI())
      : define("contentType", |this, content_type| {
          headers: set("Content-Type", content_type)
        })
    #println(exchange: getRequestURI())

    whatToDo(httpExchange)
    
    exchange: sendResponseHeaders(httpExchange: code(), httpExchange: response(): length())
    exchange: getResponseBody(): write(httpExchange: response(): getBytes())

    exchange: close()
  })

  server: createContext("/shutdown", |exchange| {
    let response = "Ok, thanks, bye!"
    exchange: getResponseHeaders(): set("Content-Type", "text/plain")
    exchange: sendResponseHeaders(200, response: length())
    exchange: getResponseBody(): write(response: getBytes())
    exchange: close()
    server: stop(5)
  })

  dynServer: httpServer(server)
    : define("start", |this| -> this: httpServer(): start())
    : define("stop", |this| {
        this: httpServer(): stop(5)
      })

  return dynServer

}

function main = |args| {

  let server = GoloHttpServer("localhost", 8081, |httpExchange| {
    println("--> " + httpExchange: uri())
    println("==> " + httpExchange: uri(): toString())
    httpExchange: response(JSON.stringify(map[
      ["message", "Hello World"],["uri", httpExchange: uri(): toString(): split("/")]
   ]))
  })

  server: start()
  println(">>> http://localhost:8081/")
}
