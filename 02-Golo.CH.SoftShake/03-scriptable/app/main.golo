module myapp

import helper
import models.humans

function main = |args| {

    let app = Application()

    app:staticFileLocation(java.io.File( "." ):getCanonicalPath() + "/app/public")
    app:port(8888)

    # first
    app:GET("/add/:a/:b",|request, response|{
        response:type("application/json")
        let a = java.lang.Integer.parseInt(request:params(":a"))
        let b = java.lang.Integer.parseInt(request:params(":b"))
        return "{\"result\":%s}":format((a+b):toString())
    })

    # Get all humans
    app:GET("/humans",|request, response|{
        let humans = Human():all():toJsonList()
        response:type("application/json")
        return humans
    })

    # Get one human by id
    app:GET("/humans/:id",|request, response|{
        response:type("application/json")
        let id = request:params(":id")
        let human = Human():queryById(id)
        return human:toJson()
    })

    # Create human
    app:POST("/humans",|request, response|{
        response:type("application/json")
        let human = Human():fromJson(request:body())
        human:save()
        return human:toJson()
    })

    # Update one human by id
    app:PUT("/humans/:id",|request, response|{
        response:type("application/json")
        let human = Human():fromJson(request:body())
        human:save()
        return human:toJson()
    })

    # Delete one human by id
    app:DELETE("/humans/:id",|request, response|{
        let id = request:params(":id")
        let human = Human():queryById(id)
        human:delete()
        response:type("application/json")
        return human:toJson()
    })
}
