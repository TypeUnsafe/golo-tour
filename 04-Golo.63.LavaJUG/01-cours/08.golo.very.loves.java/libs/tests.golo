module tests

function That = |description, something| ->
  DynamicObject():
    that(something):
    description(|this|{
      println("---------------------------------")
      println(description)
      println("---------------------------------")
    }):
    isEqualTo(|this, something, ifTrue, ifFalse|{
      this:description()
      if this:that() == something {
        return ifTrue(this:that())
      } else {
        return ifFalse(this:that())
      }
    }):
    isAString(|this, ifTrue, ifFalse|{
      this:description()
      if this:that() oftype java.lang.String.class {
        return ifTrue(this:that())
      } else {
        return ifFalse(this:that())
      }
    }):
    isNotAString(|this, ifTrue, ifFalse|{
      this:description()
      if this:that() oftype java.lang.String.class {
        return ifFalse(this:that())
      } else {
        return ifTrue(this:that())
      }
    }):    
    isAnInteger(|this, ifTrue, ifFalse|{
      this:description()
      if this:that() oftype java.lang.Integer.class {
        return ifTrue(this:that())
      } else {
        return ifFalse(this:that())
      }
    }):
    isNull(|this, ifTrue, ifFalse|{
      this:description()
      if this:that() is null {
        return ifTrue(this:that())
      } else {
        return ifFalse(this:that())
      }
    })    

    
