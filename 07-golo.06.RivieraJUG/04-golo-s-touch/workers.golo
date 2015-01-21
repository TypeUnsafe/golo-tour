module try_the_workers

import gololang.concurrent.workers.WorkerEnvironment

function main = |args| {
  let env = WorkerEnvironment.builder(): withCachedThreadPool()

  let bob = env: spawn(|message| {
    5: times(-> println(message + " 🎃"))
    sleep(200_L)
    if message:equals("kill") {env: shutdown()}
  })

  bob: send("hello"): send("yo"): send("kill")


}