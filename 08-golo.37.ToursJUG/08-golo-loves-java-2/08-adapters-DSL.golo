module dsl

#import dsl.adapters
import gololang.Adapters

function main = |args| {

  let objectAdapter = Adapter()
    : overrides("toString", |super, this| -> ">>> " + super(this))

  println(objectAdapter: newInstance(): toString())
}





