----
First, launch the broker:

		cd mqtt-broker/moquette/bin
		rm *.log
		./moquette.sh

Then run the demo:

		./go.sh

----
module sphero.mqtt

import io.connectedworkers.mqtt.device
import io.connectedworkers.toolbelt.time.helper
import io.connectedworkers.toolbelt.math.helper
import io.connectedworkers.toolbelt.files.helper
import io.connectedworkers.toolbelt.dynamic.helper

import mqtt.config

function main = |args| {

	let mybroker = broker()
		: protocol("tcp")
		: host("localhost")
		: port(1883)

	let options = mqttHelper(): getConnectOptions()

	let mqtt_device = mqttDevice(): broker(mybroker)
		: connectOptions(options)
		: initialize("bob")

	mqtt_device
		: messageArrived(|topic, message| { 
				println("["+ mqtt_device: id() +"]: " + topic + " | " + message)
			})

	let dynamicSphero = DynamicObject()
		: define("rnd", |this, min, max| {
				return rndInteger(min, max)
			})
		: define("publish", |this, topic, content| {
				mqtt_device: topic(topic): content(content): publish()
			})

	# load abilities
	let loadAbilities = -> dynamicPlugin()
		: where("abilities/main.golo")
		: from("getMain")					
		: graft(dynamicSphero)	
		: implant()

	# watcher
	let sentry = watcher(): directory("abilities")
		: callBack(|watchEvent, folderName|{ 
				println("=> " + 
					watchEvent: kind() + " " + 
					watchEvent: context() + " " + 
					folderName
				)

				# load abilities ... again
				loadAbilities()

			})
		: supervise("Supervising ...")

	

	mqtt_device: connect()
		: onSet(|token| {
				println("id: " + mqtt_device: id() + " is connected | token: " + token)

				loadAbilities()

				try {

					every(): ms(500_L): do({
						dynamicSphero: roll()
					})

					#every(): ms(500_L): times(50): do({
					#	dynamicSphero: roll()
					#})
					
				} catch(e) {
					println(e)
				}
			
			}): onFail(|error| {
				println("Huston, we've got a problem:")
				println(JSON.stringify(error))
			})



}
