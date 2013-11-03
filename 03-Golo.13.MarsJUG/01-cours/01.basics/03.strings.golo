module strings

function main = |args| {
	println("""Hello!
Ceci est du texte 
sur plusieurs
lignes
...""")

# porte les méthode de string (java)
println("Bonjour":startsWith("B"))
println("Hello":equals("Hi"))

# et plus
println("12":toInteger())
println("12":toDouble())
println("12":toDouble())
println("12":toFloat())
println("12":toLong())
}