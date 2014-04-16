module controllers.toons

import m33ki.spark
import m33ki.jackson
import models.toon

function ToonsController = |toons| { #toons is a collection

  return DynamicObject()
    : define("getAll", |this, request, response| {
      # GET request : get all models
        response: type("application/json")
        response: status(200)
        return Json(): toJsonString(toons: fetch())
    })
    : define("getOne", |this, request, response| {
      # GET request : get one model by id
        response: type("application/json")
        let id = request: params(":id")
        let toon = toons: model(): fetch(id)

        if toon isnt null{
          response: status(200)
          return toon: toJsonString()
        } else {
          response: status(404) # 404 Not found
          return Json(): toJsonString(map[["message", "PostIt not found"]])
        }
    })
    : define("create", |this, request, response| {
      # POST request : create a model
        response: type("application/json")
        let toon = toons: model(): fromJsonString(request: body())
        toon: insert() # insert in collection
        response: status(201) # 201: created
        return toon: toJsonString()
    })
    : define("update", |this, request, response| {
      # PUT request : update a model
        response: type("application/json")
        let toon = toons: model(): fromJsonString(request: body())
        toon: update() # update in collection
        response: status(200) # 200: Ok + return data
        return toon: toJsonString()
    })
    : define("delete", |this, request, response| {
      # DELETE request : delete a model
        response: type("application/json")
        let id = request: params(":id")
        let toon = toons: model(): remove(id)
        response: status(200) # 200: Ok + return data
        return toon: toJsonString()
    })

    #W.I.P.
}

