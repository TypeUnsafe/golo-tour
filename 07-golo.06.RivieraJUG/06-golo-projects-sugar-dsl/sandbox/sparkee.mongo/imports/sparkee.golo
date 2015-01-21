module sparkee

import spark.Spark

function uuid = -> java.util.UUID.randomUUID(): toString()

function port = |decoratorArgs...| {
  return |func| {
    return |functionArgs...| {
      setPort(decoratorArgs: get(0))
      return func: invokeWithArguments(functionArgs)
    }
  }
}

function static = |decoratorArgs...| {
  return |func| {
    return |functionArgs...| {
      externalStaticFileLocation(java.io.File( "." ):getCanonicalPath() + decoratorArgs: get(0))
      return func: invokeWithArguments(functionArgs)
    }
  }
}

function json = -> "application/json"
function html = -> "text/html"
function text = -> "text/plain"

function errorReport = |e| {
  let stackTrace = list[]

  stackTrace: add("<h1 style='color:black; font-family:Consolas,monospace,serif;'>Error: " + e: getMessage() + "</h1><hr>")

  e: getStackTrace(): asList(): each(|row| {
    var stringRow = row: toString()
    if stringRow: contains(".golo:") is true {
      stringRow = "<span style='color:red; font-family:Consolas,monospace,serif;'><b>" + stringRow + "</b></span>"
    } else {
      stringRow = "<span style='color:grey; font-family:Consolas,monospace,serif;'>" + stringRow + "</span>"
    }
    stackTrace: add(stringRow)
  })

  return stackTrace: join("<br>")
}


#REST verbs
function get = |decoratorArgs...| {
  return |func| {
    return |functionArgs...| {
      #println("uri: " + decoratorArgs: get(0))
      spark.Spark.get(decoratorArgs: get(0), |request, response| {
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
            return func: invokeWithArguments(functionArgs) (request, response)
          } else {
            response: type("application/json")
            return JSON.stringify(func: invokeWithArguments(functionArgs) (request, response))
          }
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }
      })
    }
  }
}

function delete = |decoratorArgs...| {
  return |func| {
    return |functionArgs...| {
      #println("uri: " + decoratorArgs: get(0))
      spark.Spark.delete(decoratorArgs: get(0), |request, response| {
        
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
            return func: invokeWithArguments(functionArgs) (request, response)
          } else {
            response: type("application/json")
            return JSON.stringify(func: invokeWithArguments(functionArgs) (request, response))
          }
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }

      })
    }
  }
}

function post = |decoratorArgs...| {
  return |func| {
    return |functionArgs...| {
      #println("uri: " + decoratorArgs: get(0))
      spark.Spark.post(decoratorArgs: get(0), |request, response| {
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
            return func: invokeWithArguments(functionArgs) (request, response)
          } else {
            response: type("application/json")
            return JSON.stringify(func: invokeWithArguments(functionArgs) (request, response))
          }
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }
      })
    }
  }
}

function put = |decoratorArgs...| {
  return |func| {
    return |functionArgs...| {
      #println("uri: " + decoratorArgs: get(0))
      spark.Spark.post(decoratorArgs: get(0), |request, response| {
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
            return func: invokeWithArguments(functionArgs) (request, response)
          } else {
            response: type("application/json")
            return JSON.stringify(func: invokeWithArguments(functionArgs) (request, response))
          }
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }
      })
    }
  }
}