module demo_workers

import gololang.concurrent.workers.WorkerEnvironment

# le WorkerEnvironment permet d'exécuter des closures dans des thread

function getWorker = |env| {

  return env: spawn(|message| {
    
    message: get(1): times(|index| {
      println(message: get(0) + " : " + index)
      Thread.sleep(1000_L)
    }) # end times
    env: shutdown()
  }) # end spawn

} 

function main = |args| {

  let env = WorkerEnvironment.builder(): withCachedThreadPool()

  getWorker(env): send(["🎃",5])
  getWorker(env): send(["🐱",4])
  getWorker(env): send(["👻",3])
  
}
