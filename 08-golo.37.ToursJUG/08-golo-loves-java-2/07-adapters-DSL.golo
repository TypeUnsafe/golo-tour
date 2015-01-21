module dsl

import gololang.Adapters


function main = |args| {
  let result = array[1,2,3]

  let runnerAdapter = Adapter()
    : interfaces(["java.io.Serializable", "java.lang.Runnable"])
    : implements("run", |this| {
        for (var i = 0, i < result: length(), i = i + 1) {
          result: set(i, result: get(i) + 10)
        }      
      })
  
  let runner = runnerAdapter: newInstance()
  runner: run()
  println(JSON.stringify(result))
}


