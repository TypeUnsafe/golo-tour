module work_with_workers

import gololang.concurrent.workers.WorkerEnvironment

function main = |args| {
	let env = WorkerEnvironment.builder():withCachedThreadPool()
	let semaphore = java.util.concurrent.Semaphore(1)

	let total = 
		DynamicObject():value(0)
			:increment(|this|{
				semaphore: acquire()
				this:value(this:value()+1)
				semaphore: release()
			})

	let w1 = env:spawn(|message| {
		println(message)
		1000:times(|i| -> total:increment())
		println("w1 : " + total:value())
	})

	let w2 = env:spawn(|message| {
		println(message)
		2000:times(|i| -> total:increment())
		println("w2 : " + total:value())
	})

	let w3 = env:spawn(|message| {
		println(message)
		if message is "end" {
			env:shutdown()
		} else  {
			3000:times(|i| -> total:increment())
			println("w3 : " + total:value())				
		}
	})

	w1:send("Hello")
	w2:send("World")
	w3:send("!!!"):send("end")

}