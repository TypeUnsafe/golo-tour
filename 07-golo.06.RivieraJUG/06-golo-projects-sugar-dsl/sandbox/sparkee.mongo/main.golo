module sparkee_demo

import sparkee

import mongodb

@post("/humans")
function createHuman = -> |req, res| {
  let data = JSON.parse(req: body())
  
  let human = HumanModel(
    data: get("firstName"), 
    data: get("lastName")
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
  initializeWebApp()
}

