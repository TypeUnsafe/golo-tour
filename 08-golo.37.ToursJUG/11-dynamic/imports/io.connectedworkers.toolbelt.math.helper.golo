----
TODO: documentation

----
module io.connectedworkers.toolbelt.math.helper

----
- parameters: min Integer, max Integer
- returns: Integer between min and max
----
function rndInteger = |min, max| {
	# TODO check that min and max are integers 
	# TODO check that min <= max
  let rand = java.util.Random()
  let randomNum = rand: nextInt((max - min) + 1) + min
  return randomNum
}

----
This main method allows tests
----
function main = |args| {

}