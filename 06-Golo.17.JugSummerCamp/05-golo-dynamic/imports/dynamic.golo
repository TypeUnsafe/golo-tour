module dynamic

----
    fileName: path from current + name of the plugin
    functionName: name of the function (to call) of the loaded module
    dyno: DynamicObject to augment

    loadPlugin(
        "plugins/controller.golo" # where
      , "signalsController" # function name
      , dynObj
    )
----
function loadPlugin = |fileName, functionName, dyno| {

  let executionEnvironment = gololang.EvaluationEnvironment()
  #current directory
  let filePath = java.nio.file.Paths.get(java.io.File( "." ): getCanonicalPath())

  #dyno: properties(): each(|property| -> dyno: undefine(property: getKey()))

  println("Loading " + fileName)
  try { # load
    let sourceCode = fileToText(filePath + "/" + fileName, "UTF-8")

    try { # compile

      let pluginModule = executionEnvironment
            : anonymousModule(sourceCode) # compile

      let mainFunctionOfModule = fun(functionName, pluginModule)

      try {
        println(fileName + " loaded")

            # reset controller
            #let sem = java.util.concurrent.Semaphore(1)
            #sem: acquire()
            #dyno: properties(): each(|property| -> dyno: undefine(property: getKey()))
            #sem: release()

        dyno: mixin(mainFunctionOfModule())

      } catch (e) {
        println("--- Execution failure ---")
        e: printStackTrace()
      }

    } catch (e) {
      println("--- Compilation failure ---")
      e: printStackTrace()
    }

  } catch (e) {
    println("--- File failure ---")
    e: printStackTrace()
  }

}


