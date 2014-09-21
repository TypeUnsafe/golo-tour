module spark_demo

import sparkee
import mongoo

# TODO: launch mongodb 😜
let mongocli = mongo(): initialize("HumansDb", "localhost", 27017)
function mg = -> mongocli

@post("/humans")
function createHuman =  -> |req, res| {
  # create a human
  let human = mg(): model("humans")
    : fromJsonString(req: body())
    : insert()

  res: redirect("/humans/"+human: id(), 301) #moved permanently
  # http://stackoverflow.com/questions/6137826/is-it-bad-to-use-301-302-redirects-after-form-submission
  # return human: toJsonString()
}

@get("/humans/:id", json())
function fetchHuman =  -> |req, res| {
  # get a human by id
  let id = req: params(":id")
  let human = mg(): model("humans"): fetch(id): toMap()
  return JSON.stringify(human)
}

@get("/humans", json())
function fetchAllHumans =  -> |req, res| {
  # get all humans
  let humans = mg(): collection("humans"): fetchMaps()
  return JSON.stringify(humans)
}

@static("/public")
@port(8080)
function initializeWebApp = {
  # initialize used routes
  fetchHuman()
  createHuman()
  fetchAllHumans()
}

function main = |args| {
  initializeWebApp()
}

