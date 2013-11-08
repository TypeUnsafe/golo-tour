module hello_handler

import org.k33g.alien.adapters

import java.io.IOException
 
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

import org.eclipse.jetty.server.Server
import org.eclipse.jetty.server.Request
#import org.eclipse.jetty.server.handler.AbstractHandler


function main = |args| {
  
  let HelloHandler = Adapter(): extends("org.eclipse.jetty.server.handler.AbstractHandler")
    :implements( # AbstractHandler implements "handle"
      methods()
        :handle(|this, target, baseRequest, request, response| {
          response:setContentType("text/html;charset=utf-8")
          response:setStatus(HttpServletResponse.SC_OK())
          baseRequest:setHandled(true)
          response:getWriter():println("<h1>Golo Rocks</h1>")
        })
    )

  let server = Server(8080)
  server:setHandler(HelloHandler: make(): newInstance())
 
  server:start()
  server:join()

}