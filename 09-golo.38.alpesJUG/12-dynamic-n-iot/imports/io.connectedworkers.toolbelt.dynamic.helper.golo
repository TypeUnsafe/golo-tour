----
TODO: documentation and a implant method that returns a promise

----
module io.connectedworkers.toolbelt.dynamic.helper

----
dynamicPlugin structure:
		
		dynamicPlugin()
			: where("plugins/plugin.golo") 	# fileName: path from current + name of the plugin		
			: from("getAbilities")					# functionName: name of the function (to call) of the loaded module
			: graft(dyno)										# dyno: DynamicObject to "augment"
		
plugin sample:

		function getAbilities = |args...| {
		  println("getAbilities called")
		  println("args: " + JSON.stringify(args))

		  return DynamicObject()
		    : define("about", |this| -> println("I'm Plug One."))	
		}
----
struct dynamicPlugin = { 
	where, 
	from,
	graft
}

----
dynamicPlugin augmentations
----
augment dynamicPlugin {
----
	you can pass parameters to the this: from() function
		dynamicPlugin()
			: where("plugins/plug1.golo") 	# fileName: path from current + name of the plugin		
			: from("getAbilities")					# functionName: name of the function (to call) of the loaded module
			: graft(dyno)										# dyno: DynamicObject to "augment"
			: implant(42, 0, 1)
----
	function implant = |this, params...| {
		let fileName = this: where()
		let functionName = this: from()
		let dyno = this: graft()

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

	        dyno: mixin(mainFunctionOfModule(params))

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
	  return this
	}
	function implant = |this| {
		return this: implant(null)
	}
} 

----
This main method allows tests
----
function main = |args| {

	let nakedDyno = DynamicObject()

	dynamicPlugin()
		: where("plugins/plug1.golo")
		: from("getAbilities")					
		: graft(nakedDyno)										
		: implant(42, "nakedDyno")

	nakedDyno: about()

	nakedDyno: name("Bob")

	dynamicPlugin()
		: where("plugins/plug2.golo")
		: from("getOtherAbilities")					
		: graft(nakedDyno)										
		: implant()

	nakedDyno: sayHello()
	
}

