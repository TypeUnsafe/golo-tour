module humans

import fast.json.Json
import java.util.HashMap
import java.util.LinkedList

import redis.clients.jedis.Jedis

import java.util.UUID

import fast.store.MemoryStore

function db = -> Jedis("localhost")

#GET /humans/:id
function fetch = |request, response| {

    let id = request:params(":id") #route : /humans/:id

    let human =  Json.parse(db():get(id))

    response:type("application/json")
    return Json.stringify(Json.toJson(human))

}

#POST /humans
function create = |request, response| {

    let jsonNode = Json.parse(request:body())

    let human = Json.fromJson(jsonNode, HashMap.class)

    let id = UUID.randomUUID():toString()

    human:put("id", id)

    db():set(id, Json.stringify(Json.toJson(human)))

    response:type("application/json")
    return Json.stringify(Json.toJson(human))
}

#PUT /humans/:id
function save = |request, response| {

    let jsonNode = Json.parse(request:body())

    let human = Json.fromJson(jsonNode, HashMap.class)

    let id = request:params(":id") #route : /humans/:id

    human:put("id", id)

    db():set(id, Json.stringify(Json.toJson(human)))

    response:type("application/json")
    return Json.stringify(Json.toJson(human))
}

#DELETE /humans/:id
function delete = |request, response| {

    let id = request:params(":id") #route : /humans/:id

    response:type("application/json")
    return Json.stringify(Json.toJson(db():del(id)))

}


#GET /humans
function fetchAll = |request, response| {
    
    response:type("application/json")

    let modelsList = LinkedList()
    let allKeys = db():keys("*")

    foreach (key in allKeys) {

        let modelJsonNode =  Json.parse(db():get(key))
        let modelHashMap = Json.fromJson(modelJsonNode, HashMap.class)
        #println(modelJsonNode)
        modelsList: add(modelHashMap)
    }

    return Json.stringify(Json.toJson(
        modelsList:toArray()
    ))

}
