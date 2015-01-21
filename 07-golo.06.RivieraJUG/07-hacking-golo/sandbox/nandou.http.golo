module nandou.Http

import nandou.File

struct http = { server, port }
struct options = { protocol, host, port, path, encoding, userAgent, contentType }
struct callbacks = { success, error }
struct url = { parts }
struct session = { httpExchange, id }
struct request = { httpExchange, method, uri, requestedUri, url, session, tmpData }
struct response = { httpExchange, headers, body, code, message, text, contentLoaded, encoding }

augment nandou.Http.types.session {

    function create = |this, cookieName|{
        this:id(java.util.UUID.randomUUID():toString())
        let session_id = cookieName + "=" + this:id() + ";"
        this:httpExchange():
            getResponseHeaders()
            :add("Set-Cookie",session_id)
        return this
    }

    function delete = |this, cookieName| {
        if this:id() isnt null {
            let session_id = cookieName + "=" + this:id()
            this: httpExchange():
                getResponseHeaders():
                add("Set-Cookie", String.format("%s=; Expires=Thu, 01 Jan 1970 00:00:00 GMT", session_id))
            this:id(null)
        }
        return this
    }

    function current = |this, cookieName| {

        let cookie = this:httpExchange():getRequestHeaders():get("Cookie")

        if cookie isnt null {
            let myCookie = cookie:toString():split(cookieName + "=")
            if myCookie:length() > 1 {
                let myCookieStr = myCookie:get(1)
                if myCookieStr:length() > 0 {
                    let id = myCookieStr:split(";"):get(0):split("]"):get(0)
                    this:id(id)
                }
            }
        }
        return this
    }
}

augment nandou.Http.types.url {
    function firstPart = |this| -> this:parts():get(0)
    function lastPart = |this| -> this:parts():get(this:parts():length() - 1)
}

augment nandou.Http.types.http {

    function listen = |this, port| {
        let addr = java.net.InetSocketAddress(port)
        let server = com.sun.net.httpserver.HttpServer.create(addr, 0)

        server:createContext("/", this:server():to(com.sun.net.httpserver.HttpHandler.class))
        server:setExecutor(java.util.concurrent.Executors.newCachedThreadPool())
        #server:setExecutor(java.util.concurrent.Executors.newFixedThreadPool(50))
        #server:setExecutor(java.util.concurrent.Executors.newSingleThreadExecutor())

        server:start()
        this:port(port)
        return this
    }

    function syncGet = |this, options, callbacks| {

        let url = options:protocol()+"://"+options:host()+":"+options:port()+options:path()
        #println("start downloading ... : " + url )

        try {
            let obj = java.net.URL(url) # URL obj
            let con = obj:openConnection() # HttpURLConnection con (Cast?)
            #optional default is GET
            con:setRequestMethod("GET")

            if options:contentType() is null {
                options:contentType("text/plain; charset=utf-8")
            }
            con:setRequestProperty("Content-Type", options:contentType())

            #add request header
            if options:userAgent() is null {
                options:userAgent("Mozilla/5.0")
            }
            con:setRequestProperty("User-Agent", options:userAgent())

            let responseCode = con:getResponseCode() # int responseCode
            let responseMessage = con:getResponseMessage() # String responseMessage

            let responseText = java.util.Scanner(con:getInputStream(), options:encoding()):useDelimiter("\\A"):next() # String responseText

            let success = callbacks:success()

            if success isnt null {
                success(response()
                    :code(responseCode)
                    :message(responseMessage)
                    :text(responseText)
                )
            }

        } catch(e) {
            let error = callbacks:error()
            if error isnt null { error(e) } else { raise("Huston, we've got a problem", e) }
        }

    }

    function aSyncGet = |this, options, callbacks| {
        let executor = java.util.concurrent.Executors.newCachedThreadPool()
        try {
            executor:submit((-> this:syncGet(options, callbacks)):to(java.util.concurrent.Callable.class))
        } finally {
            executor:shutdown()
        }
    }

    function sget = |this, options, callbacks| -> this:syncGet(options, callbacks)
    function aget = |this, options, callbacks| -> this:aSyncGet(options, callbacks)
}

augment nandou.Http.types.response {

    function contentType = |this, contentType| {
        this:headers():set("Content-Type", contentType)
        return this
    }

    function json = |this|{
        this:contentType("application/json")
        return this
    }

    function xml = |this|{
        this:contentType("application/xml")
        return this
    }

    function html = |this|{
        this:contentType("text/html")
        return this
    }

    function text = |this|{
        this:contentType("text/plain")
        return this
    }


    function write = |this, something| {
        if this:code() is null {this:code(200)}
        this:httpExchange():sendResponseHeaders(this:code(), 0)
        this:body(this:httpExchange():getResponseBody())
        this:body():write(something:getBytes())
        return this
    }

    # to delete
    function loadHtml = |this, path, encoding| {
        #let home = fileToText(public + "/index.html", "UTF-8")
        let page = fileToText(path, encoding)
        this:html():send(page)
        return this
    }

    function load = |this, path| {
        if this:encoding() is null {
            this:encoding("UTF-8")
        }
        this:contentLoaded(fileToText(path, this:encoding()))
        return this
    }

    function redirect = |this, location| {
        #this:headers():set("Content-Type", contentType)
        this:code(302)
        this:headers():set("Location", location)
        this:write("")

        this:close()

        return this
    }

    function close = |this| -> this:body():close()

    function send = |this, something| -> this:write(something):close()

    function send = |this| {
        this:write(this:contentLoaded()):close()
        #empty contentLoaded  and encoding
        this:contentLoaded(null)
        this:encoding(null)
    }

    function renderView = |this, path, parameterName, data2render| {
        #load template
        if fileExists(path) {
            try {
                let body = "<%@params " + parameterName + " %>" + fileToText(path, "UTF-8")
                # template compilation
                let tpl = gololang.TemplateEngine(): compile(body)
                let content = tpl(data2render)

                this:contentType("text/html"):code(200)
                    :write(content)
                    :close()
            } catch(e) {
                this:contentType("text/html"):code(500)
                    :write("<b>500</b> : Huston we've got a problem!")
                    :close()
            }
        } else {
            this:contentType("text/html"):code(404)
                :write("<b>404</b> : Oh Oh! Try Again!")
                :close()
        }
    }
}

augment nandou.Http.types.request {

    function data = |this| { #TODO:save this somewhere / use when POST or PUT

        if this:tmpData() is null {
            let inputStream = this:httpExchange():getRequestBody()
            let inputStreamReader = java.io.InputStreamReader(inputStream)
            let bufferedReader = java.io.BufferedReader(inputStreamReader)
            let stringRead = bufferedReader:readLine()
            this:tmpData(stringRead)
            return stringRead
        } else {
            return this:tmpData()
        }

    }

    function parameter = |this|-> this:url():lastPart()

    function parameters = |this|-> this:url():parts()


}


struct route = { httpExchange, request, response }

augment nandou.Http.types.route {

    function httpVerb = |this, path, verb| {
        #to be refactored / rewritten
        let route = -> this:request():method() + ":" + this:request():uri()

        if path:endsWith(":var") {

            let start = verb + ":" + path:split(":var"):get(0)
            let endOfUri = route():split(start)
            if endOfUri:size() > 1 {
                if (start + endOfUri:get(1)):equals(route()) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }

        } else {
            if route():equals(verb + ":" + path) or route():equals(verb + ":" + path + "/") {
                return true
            } else {
                return false
            }
        }

    }

    function GET = |this, path, callback| {
        if this:httpVerb(path, "GET") {
            callback(this:request(), this:response())
        }
    }

    function DELETE = |this, path, callback| {
        if this:httpVerb(path, "DELETE") {
            callback(this:request(), this:response())
        }
    }

    function PUT = |this, path, callback| {
        if this:httpVerb(path, "PUT") {
            callback(this:request(), this:response())
        }
    }

    function POST = |this, path, callback| {

        #let route = -> this:request():method() + ":" + this:request():uri()

        #if route():equals("POST:" + path) or route():equals("POST:" + path + "/") {
        #    callback(this:request(), this:response())
        #}

        if this:httpVerb(path, "POST") {
            callback(this:request(), this:response())
        }
    }

}

augment com.sun.net.httpserver.HttpExchange {

    function route = |this| -> route():httpExchange(this):request(this:request()):response(this:response())

    function GET = |this, path, callback| {
        this:route():GET(path, callback)
    }

    function DELETE = |this, path, callback| {
        this:route():DELETE(path, callback)
    }

    function PUT = |this, path, callback| {
        this:route():PUT(path, callback)
    }

    function POST = |this, path, callback| {
        this:route():POST(path, callback)
    }

    function request = |this| {
        let requestedUri = this:getRequestURI()
        let uri = requestedUri:toString()
        let method = this:getRequestMethod()

        var urlParts = array["/"]
        let parts = java.net.URLDecoder.decode(uri):split("/")
        if parts:length() > 0 {
            urlParts = java.util.Arrays.copyOfRange(parts, 1, parts:length())
        }

        let req = request()
            :httpExchange(this)
            :requestedUri(requestedUri) #useful or not ?
            :method(method)
            :uri(uri)
            :url(url():parts(urlParts))
            :session(session():httpExchange(this))

        #if method == "POST" {
        #    req:data(req:getData())
        #}

        return req
    }

    function response = |this| {
        return response()
            :httpExchange(this)
            :headers(this:getResponseHeaders())
            :body(null)
    }

    function getContentTypeOfFile = |this, path| {
        let filename = fileName(path)
        var mime = java.net.URLConnection.getFileNameMap():getContentTypeFor(filename)
        if mime is null {
            let which_content_type = |filename| -> match {
                when filename:contains(".htm") then "text/html"
                when filename:contains(".css") then "text/css"
                when filename:contains(".js")  then "application/javascript"
                when filename:contains(".json") then "application/json"
                when filename:contains(".ico") then "image/ico"
                when filename:contains(".xml") then "application/xml"
                when filename:contains(".md") then "text/plain"
                when filename:contains(".txt") then "text/plain"
                otherwise "text/plain"
            }
            mime = which_content_type(filename)
        }
        return mime
    }

    function serveStaticFiles = |this, staticFileLocation| {
            let request = this:request()
            let response = this:response()

            let path = staticFileLocation + request:uri()

            if fileExists(path) {
                let contentType = this:getContentTypeOfFile(path)
                #println("fileName : " + fileName(path) + " content-type : " + contentType)
                try {
                    let text = fileToText(path, "UTF-8")
                    response:contentType(contentType):code(200)
                        :write(text)
                        :close()
                } catch(e) {
                    response:contentType("text/html"):code(500)
                        :write("<b>500</b> : Huston we've got a problem!")
                        :close()
                }
            } else {
                response:contentType("text/html"):code(404)
                    :write("<b>404</b> : Oh Oh! Try Again!")
                    :close()
            }
    }

}



