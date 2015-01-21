module sparkee_demo

import sparkee
import mongodb

function HumansCollection = -> MongoCollection("humans")

function HumanModel = |firstName, lastName| ->
  MongoModel(HumansCollection())
    : set("firstName", firstName)
    : set("lastName", lastName)

@post("/humans")
function createHuman = -> |req, res| {
  
  let human = HumanModel(
    req: data("firstName"), req: data("lastName")
  ): insert()
  
  return human: fields()
}

@get("/humans")
function allHumans = -> |req, res| {
  return HumansCollection(): find()
}

@static("/public")
@port(8080)
function initializeWebApp = {
  # initialize used routes
  createHuman()
  allHumans()
}

function main = |args| {
  # initialize MongoDb configuration
  MongoConf("localhost", 27017, "HumansDb")
  
  initializeWebApp()
}

