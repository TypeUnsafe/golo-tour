module little.server

#http
import java.net.InetSocketAddress
import com.sun.net.httpserver
import com.sun.net.httpserver.HttpServer

import java.net.HttpURLConnection
import java.net.URL
import java.net.URLEncoder

augment java.lang.String {
  # interpolate
	function fitin = |this, dataName, data| {
		let tpl = gololang.TemplateEngine()
							:compile("<%@params "+dataName+" %> "+this)
		return tpl(data)
	}
}

function http = |port| {
	let handler = |fct| -> fct: to(HttpHandler.class)
	let server = HttpServer.create(InetSocketAddress("localhost", port), 0)
	let node = DynamicObject()
		:server(|this, intelligence|{
			server: createContext("/", handler(|exchange|{
				let httpExchange = DynamicObject()
					:headers(exchange: getResponseHeaders())
					:uri(exchange: getRequestURI():toString())
					:contentType(|this, content_type|{
						this: headers(): set("Content-Type", content_type)
						return this
					})
					:write(|this, response|{
		        exchange: sendResponseHeaders(200, response: length())
		        exchange: getResponseBody(): write(response: getBytes())
		        exchange: close()
		        return this
					})
				intelligence(httpExchange)
			}))
			return this
		})
		:start(|this| {
			server: start()
			println("listening on " + port)
		})
	return node
}






