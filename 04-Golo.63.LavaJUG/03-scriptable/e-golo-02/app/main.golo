module myapplication

function Json = -> DynamicObject()
    :define("toTreeMap", |this, something|-> json.Json.fromJson(json.Json.parse(something), java.util.TreeMap.class))
    :define("stringify", |this, something|-> json.Json.stringify(json.Json.toJson(something)))

function Human = -> DynamicObject()
    :fields(map[])
    :define("toJson", |this| -> Json():stringify(this:fields()))
    :define("fromJson", |this, body| {
        this:fields( Json():toTreeMap(body) )
        return this
    })
    :define("generateId", |this|{
        this:fields():put("id", java.util.UUID.randomUUID())
        return this
    })

function main = |args| {

    let app = Application()

    app:staticFileLocation(java.io.File( "." ):getCanonicalPath() + "/app/public")
    app:port(8888)

    # new one
    app:POST("/humans",|request, response|{
        response:type("application/json")
        let human = Human(): fromJson(request: body()): generateId()
        Application.humansList():add(human:fields())
        return human:toJson()
    })

    # getAll
    app:GET("/humans",|request, response|{
        response:type("application/json")
        return Json():stringify(Application.humansList())
    })

    # Delete one human by id
    app:DELETE("/humans/:id",|request, response|{

        let fields = Application.humansList():filter(|humanFields|{
            return humanFields:get("id"):toString()
                :equals(request:params(":id"):toString())
        }):peek()

        Application.humansList():remove(fields)

        response:type("application/json")
        return Json():stringify( Human(): fields(fields) )
    })


}


