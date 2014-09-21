module promise_demo

#  j'💖️ javascript
import gololang.Async
import gololang.concurrent.async.Promise

function main = |args| {

  let divide42 = {
    
    return Promise(): initialize(|resolve, reject| {
      # do a thing, possibly async, then…
      let randomNumber = java.util.Random():nextInt(5)
      if randomNumber > 0 {
        let result = 42.0 / randomNumber
        # every thing is fine
        resolve([randomNumber, result])
      } else {
        reject(java.lang.Exception("Divided by 0!"))
      }
    })
  }
  
  10: times({

    divide42()
      : onSet(|values| { #then
          println("😊 👍 42/" + values: get(0) + "=" + values: get(1))
        })
      : onFail(|err| { #catch
          println("😡 👎 ouch!: " + err: getMessage())
        })
  })
  
}