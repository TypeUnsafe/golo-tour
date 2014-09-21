module sparkee

import spark.Spark

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

function errorReport = |e| {
  let stackTrace = list[]

  stackTrace: add("<h1>" + e: getMessage() + "</h1><hr>")

  e: getStackTrace(): asList(): each(|row| {
    var stringRow = row: toString()
    if stringRow: contains(".golo:") is true {
      stringRow = "<b style='color:red;'>" + stringRow + "</b>"
    }
    stackTrace: add(stringRow)
  })

  return stackTrace: join("<br>")
}

#REST verbs
function get = |decoratorArgs...| {
  print("get decorator: ")
  return |func| {
    return |functionArgs...| {
      println("uri: " + decoratorArgs: get(0))
      spark.Spark.get(decoratorArgs: get(0), |request, response| {
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
          } else {
            response: type("text/plain")
          }
          return func: invokeWithArguments(functionArgs) (request, response)
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }
      })
    }
  }
}

function delete = |decoratorArgs...| {
  print("delete decorator: ")
  return |func| {
    return |functionArgs...| {
      println("uri: " + decoratorArgs: get(0))
      spark.Spark.delete(decoratorArgs: get(0), |request, response| {
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
          } else {
            response: type("text/plain")
          }
          return func: invokeWithArguments(functionArgs) (request, response)
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }
      })
    }
  }
}

function post = |decoratorArgs...| {
  print("post decorator: ")
  return |func| {
    return |functionArgs...| {
      println("uri: " + decoratorArgs: get(0))
      spark.Spark.post(decoratorArgs: get(0), |request, response| {
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
          } else {
            response: type("text/plain")
          }
          return func: invokeWithArguments(functionArgs) (request, response)
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }
      })
    }
  }
}

function put = |decoratorArgs...| {
  print("put decorator: ")
  return |func| {
    return |functionArgs...| {
      println("uri: " + decoratorArgs: get(0))
      spark.Spark.post(decoratorArgs: get(0), |request, response| {
        try {
          if decoratorArgs: size() > 1 {
            response: type(decoratorArgs: get(1))
          } else {
            response: type("text/plain")
          }
          return func: invokeWithArguments(functionArgs) (request, response)
        } catch (e) {
          response: type("text/html")
          return errorReport(e)
        }
      })
    }
  }
}