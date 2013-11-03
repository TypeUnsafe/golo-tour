module org.fortytwo.H2G2

import gololang.concurrent.workers.WorkerEnvironment

function enHouse = -> 
	WorkerEnvironment.builder()
		:withCachedThreadPool()

function getWorker = |callback, enHouse| {
	return 	enHouse:spawn(|message| {
		callback:run(message)
		enHouse:shutdown()
	})
}


