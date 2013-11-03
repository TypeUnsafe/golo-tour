module hello.world

import little.server

function main = |args| {
	
	http(8080):server(|httpExchange|{

		let messages = list[
			  "Little HttpServer"
			, "Golo powered"
			, "url : " + httpExchange: uri()
		]

		let html_response = """
			<style type="text/css">
				body { 
				    font-family: Helvetica, Arial;
				    font-size: 48px;
				    color: #3A4244;
				}
			</style>
			<h1>Hello MarsJUG</h1>
			<ul> 
			<% messages: each(|message| { %>
				<li><%= message %></li>
			<% }) %>
			</ul>
		"""
		:fitin("messages", messages)

		httpExchange:contentType("text/html"):write(html_response)

	}):start()

}
