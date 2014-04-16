module routes.toons

import m33ki.spark
import models.toon
import controllers.toons

function defineToonsRoutes = {

  # Collection Helper
  let toons = Toons()

  GET("/alltoons", |request, response| {
    response: type("application/json")
    return acme.Toons.all()
  })

  # Create Toon
  POST("/toons", |request, response| {
    return ToonsController(toons): create(request, response)
  })

  # Retrieve all Toons
  GET("/toons", |request, response| {
    return ToonsController(toons): getAll(request, response)
  })

  # Retrieve Toon by id
  GET("/toons/:id", |request, response| {
    return ToonsController(toons): getOne(request, response)
  })

  # Update Toon
  PUT("/toons/:id", |request, response| {
    return ToonsController(toons): update(request, response)
  })

  # delete Toon
  DELETE("/toons/:id", |request, response| {
    return ToonsController(toons): delete(request, response)
  })

}
