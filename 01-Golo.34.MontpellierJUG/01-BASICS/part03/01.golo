module demo

pimp java.lang.String {
	function append = |this, s| -> this + s
} 

#pimp = augment

function main = |args| {
	println(
		"Hello":append(" World")
			:append(" !")
	)
}
