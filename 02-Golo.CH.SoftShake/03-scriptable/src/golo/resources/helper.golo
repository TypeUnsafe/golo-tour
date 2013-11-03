module helper

#This is a resource : embedded in the jar

function hello = -> println("hello from embedded resource")

function fromJson = |jsonString| -> json.Json.fromJson(json.Json.parse(jsonString), java.util.TreeMap.class)

function toJson = |obj| -> json.Json.stringify(json.Json.toJson(obj))
