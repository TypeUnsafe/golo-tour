module try_the_workers

import gololang.concurrent.workers.WorkerEnvironment

#  jack 🎃 bob 🐱 

function main = |args| {
  let env = WorkerEnvironment.builder(): withCachedThreadPool()

  # like a thread but better
  let jack = env: spawn(|message| {
    
    if message: equals("kill") {
      env: shutdown()
    } else {
      5: times(-> println(message + " 🎃"))
      Thread.sleep(200_L)
    }

  })

  let bob = env: spawn(|message| {
    10: times(-> println(message + " 🐱"))
    Thread.sleep(300_L)
  })

  bob: send("hello")
  
  jack: send("hi")
      : send("yo")
      : send("kill")


}