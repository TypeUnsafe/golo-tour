module demo

#PI serial vs //

import gololang.concurrent.workers.WorkerEnvironment
import java.util.HashMap
import java.lang.System

#formule de Wallis (1616-1703 Anglais)
function pieceOfPI = |start, end| {
	let piece = 1
	for(var i = start, i < (end + 1), i = i + 2 ) {
		#println((i * i) +" / "+ (i * i - 1))
		piece = piece * (i * i) / (i * i - 1)  
	}
	return piece
}

function serialPI = {
	let start = System.currentTimeMillis()
	println("PI = " + 2*pieceOfPI(2.0, 30000000.0))
	let duration = System.currentTimeMillis() - start
	println("(Serial)Duration : " + duration + " ms")
}

function main = |args| {
	
	let enHouse = WorkerEnvironment.builder(): withCachedThreadPool()

	let products = HashMap()
		:add(1,0.0)
		:add(2,0.0)
		:add(3,0.0)


	let pi1 = enHouse:spawn(|start| {
		products:put(1, pieceOfPI(2.0, 100000000.0))
		#println(products:get(1))
		println("PI1 = " + 2 * products:get(1) * products:get(2) * products:get(3))
		let duration = System.currentTimeMillis() - start
		println("(PI1)Duration : " + duration + " ms")
		enHouse:shutdown()
	
	})

	let pi2 = enHouse:spawn(|start| {
		products:put(2, pieceOfPI(100000002.0, 200000000.0))
		#println(products:get(2))
		println("PI2 = " + 2* products:get(1) * products:get(2) * products:get(3))
		let duration = System.currentTimeMillis() - start
		println("(PI2)Duration : " + duration + " ms")
	})

	let pi3 = enHouse:spawn(|start| {
		products:put(3, pieceOfPI(200000002.0, 300000000.0))
		#println(products:get(3))
		println("PI3 = " + 2* products:get(1) * products:get(2) * products:get(3))
		let duration = System.currentTimeMillis() - start
		println("(PI3)Duration : " + duration + " ms")
	})

 	serialPI()

	pi1:send(System.currentTimeMillis())
	pi2:send(System.currentTimeMillis())
	pi3:send(System.currentTimeMillis())

}



