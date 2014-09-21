function signalsController = {
  println("signalsController called")

  return DynamicObject()
    : define("about", |this| -> println("I'm the Signals Controller."))
    : define("dispatch", |this, request| {

        let signal = request: params(":signal")
        let values = request: params(":values")

        # check if method exists
        if this: hasMethod(signal) is true {
          return JSON.stringify(this: get(signal) (this, values))
        } else {
          return JSON.stringify(DynamicObject(): error("bad signal"))
        }
      })
    : define("light", |this, values| {
        println("--> Signal = LIGHT")
        return DynamicObject()
                : signal("light")
                : values(values: split("-"))
      })
     : define("sound", |this, values| {
        println("--> Signal = SOUND")
        return DynamicObject()
                : signal("sound")
                : values(values: split("-"))
      })   
#-> here add sound signal

}
