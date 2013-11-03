module numbers

function main = |args| {

	#instance -> : 
	println(42:toHexString())

	println(42.0:compare(53.3))
	println(42.0:compareTo(53.3))
	println(42.0:compare(42.0))

	#static -> .
	println(
		java.lang.Integer.toHexString(42)
	)
	println(
		java.lang.Double.compare(42.0,53.3)
	)

}