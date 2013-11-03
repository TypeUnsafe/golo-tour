module routes

import fast.routes.Router

import java.util.HashMap


function routes = |arg| {


    Router.GET("/humans", "/controllers/humans.golo", "fetchAll")

    Router.POST("/humans", "/controllers/humans.golo", "create")

    Router.GET("/humans/:id", "/controllers/humans.golo", "fetch")

    Router.PUT("/humans/:id", "/controllers/humans.golo", "save")

    Router.DELETE("/humans/:id", "/controllers/humans.golo", "delete")

}