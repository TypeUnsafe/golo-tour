module hacking

import gololang.Toolbelt


function main = |args| {
  
  let t = timer(): start(|self| {
    println(Toon(): name())
    println(Toon(): name())
    println(Toon(): name())
  }): stop(|self|{
    println(self: duration() + " ms")
  })


}

