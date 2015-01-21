----
TODO: documentation

###Augmented structures:

- every
- ...
----
module io.connectedworkers.toolbelt.time.helper

struct every = { 
	ms,
	times
}
----
ex: do something each 500 ms

		every(): ms(500_L): do({
			# foo
		})

ex: do something 10 times each 500 ms

		every(): ms(500_L): times(10): do({
			# foo
		})

----
augment every {
	function do = |this, closure| { # run this inside a worker
		let work = {
			closure()
			sleep(this: ms())			
		}
		if this: times() is null {
			while true { work() }			
		} else {
			this: times(): times({ work() })
		}	
	}
} 

----
This main method allows tests
----
function main = |args| {

}


