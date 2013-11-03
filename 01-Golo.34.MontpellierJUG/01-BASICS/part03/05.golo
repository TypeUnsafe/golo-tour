module demo

#workers [env] [w1] [w2]

import gololang.concurrent.workers.WorkerEnvironment

function main = |args| {

let enHouse = WorkerEnvironment.builder()
	:withCachedThreadPool()

	let worker1 = enHouse:spawn(|message| {
		println("w1 : " + message)
		for (var i = 0, i <10, i = i + 1)  {
			println("[%s] w1 : %s":format(message,i)) 
		}
	})

	let worker2 = enHouse:spawn(|message| {
		println("w2 : " + message)
		for (var i = 0, i <10, i = i + 1)  {
			println("[%s] w2 : %s":format(message,i)) 
		}
		if message:equals("shutdown") {enHouse:shutdown()}
	})

	worker1:send("GO"):send("GOGO")
	worker2:send("FEU")

}