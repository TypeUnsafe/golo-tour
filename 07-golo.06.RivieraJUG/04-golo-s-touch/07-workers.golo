module try_the_workers

import gololang.concurrent.workers.WorkerEnvironment

#  bob 🎃 sam 🐱 

function main = |args| {
  let env = WorkerEnvironment.builder(): withCachedThreadPool()

  let bob = env: spawn(|message| {
    5: times(-> println(message + " 🎃"))
    Thread.sleep(200_L)
    if message:equals("kill") {env: shutdown()}
  })

  let sam = env: spawn(|message| {
    5: times(-> println(message + " 🐱"))
    Thread.sleep(200_L)
    if message:equals("kill") {env: shutdown()}
  })

  bob: send("hello")
  sam: send("hi"): send("yo"): send("kill")


}