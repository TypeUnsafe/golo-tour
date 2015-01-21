module sparkee_demo

import sparkee
#spark


@static("/public")
@port(8080)
function initializeWebApp = {
  # initialize used routes

}

function main = |args| {
  initializeWebApp()
}

