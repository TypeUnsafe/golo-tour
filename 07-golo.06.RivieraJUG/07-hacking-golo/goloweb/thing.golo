module thing

import gololang.web

function main = |args| {
  let thingID = uuid()
  let name = Toon(): name()
  
  syncGet("http://localhost:8081/hello/id/%s/name/%s"
          : format(thingID, name), 
    |code, message, text| {
      println("code: " + code)
      println("message: " + message)

      println(JSON.parse(text))

    }, 
    |error| -> println(error)
  )

}