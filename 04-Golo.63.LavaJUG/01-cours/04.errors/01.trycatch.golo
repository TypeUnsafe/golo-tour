module trycatch

function main = |args| {
	try {
		raise("Ouch!")
		#throw java.lang.RuntimeException("Ouch!")
	} catch (e) {
		e: printStackTrace()
	} finally {
		println("on va finir par y arriver")
	}
}