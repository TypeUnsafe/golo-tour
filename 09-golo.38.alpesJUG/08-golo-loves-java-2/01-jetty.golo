module playwithjetty

import gololang.Adapters

import org.eclipse.jetty.server.Server
import org.eclipse.jetty.server.handler.ContextHandler
import org.eclipse.jetty.server.handler.ContextHandlerCollection
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

function HelloHandler = |message| {
  # Golo 2.1.0
  let handler = Adapter()
    : extends("org.eclipse.jetty.server.handler.AbstractHandler")
    : implements("handle", |this, target, baseRequest,request, response| {
      
        response: setContentType("text/html; charset=utf-8")
        response: setStatus(HttpServletResponse.SC_OK())
 
        let out = response: getWriter()
        out: println("<h1>" + message + "</h1>")
 
        baseRequest: setHandled(true)
      })
  return handler
}

function main = |args| {
  #
  let server = Server(8080)

  let context = ContextHandler("/")
  context: setHandler(HelloHandler("Root: Hello"): newInstance())
 
  let contextFR = ContextHandler("/fr")
  contextFR: setHandler(HelloHandler("Racine: Salut"): newInstance())

  let contexts = ContextHandlerCollection()

  let contextsArray = newTypedArray(ContextHandler.class, 2)
  contextsArray: set(0, context)
  contextsArray: set(1, contextFR)

  contexts: setHandlers(contextsArray)

  server: setHandler(contexts)

  server: start()
  server: join()
}