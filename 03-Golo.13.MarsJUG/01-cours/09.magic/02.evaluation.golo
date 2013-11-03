module evaluation_string

function code = ->
"""
module math

function addition = |a, b| -> a + b

function substraction = |a, b| -> a - b
"""

function main = |args| {
	let env = gololang.EvaluationEnvironment()
	let math_module = env:asModule(code())

	let one = fun("addition", math_module)
	let two = fun("substraction", math_module)

	println( one(4,6) + " " + two(6,4) )
	
}