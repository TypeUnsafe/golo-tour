----
This is a little fluent DSL "around" Paho client library

see [Paho java client library](http://www.eclipse.org/paho/files/javadoc/overview-summary.html)

sample: 

	let mybroker = broker()
		: protocol("tcp")
		: host("localhost")
		: port(1883)

	let options = mqttHelper(): getConnectOptions()

	let johnDoeDevice = mqttDevice(): broker(mybroker): connectOptions(options): initialize()

	johnDoeDevice
		: messageArrived(|topic, message| { 
				println("["+ johnDoeDevice: id() +"] you've got a mail : " + topic + " | " + message)
				johnDoeDevice: topic("all"): content("I've got a mail!"): publish()
			})

	johnDoeDevice: connect()
		: onSet(|token| {
			println("id: " + johnDoeDevice: id() + " is connected | token: " + token)
			johnDoeDevice: subscribe("hi")
		}): onFail(|error| {
			println("Huston, we've got a problem:")
			println(JSON.stringify(error))
		})			


----
module io.connectedworkers.mqtt.device

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken
import org.eclipse.paho.client.mqttv3.MqttCallback

import org.eclipse.paho.client.mqttv3.MqttClient
import org.eclipse.paho.client.mqttv3.MqttAsyncClient
import org.eclipse.paho.client.mqttv3.MqttConnectOptions
import org.eclipse.paho.client.mqttv3.MqttException
import org.eclipse.paho.client.mqttv3.MqttMessage
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence

import gololang.Async

import io.connectedworkers.dsl.adapter

----
IMqttActionListener adapter

- see [http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/IMqttActionListener.html](http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/IMqttActionListener.html)

Implementors of this interface will be notified when an asynchronous action completes.
A listener is registered on an MqttToken and a token is associated with an action like connect or publish. 
When used with tokens on the MqttAsyncClient the listener will be called back on the MQTT client's thread. 
The listener will be informed if the action succeeds or fails. 
It is important that the listener returns control quickly otherwise the operation of the MQTT client will be stalled.
----
function actionListenerCallback = |onSuccessCbk, onFailureCbk| {
	let actionListenerCallbackDefinition = Adapter(): interfaces(["org.eclipse.paho.client.mqttv3.IMqttActionListener"])
		: implements("onSuccess", |this, asyncActionToken| {
				onSuccessCbk(asyncActionToken)
			})
		: implements("onFailure", |this, asyncActionToken, exception| {
				onFailureCbk(asyncActionToken, exception)
			})		
		: definition()

	return AdapterFabric()
		: maker(actionListenerCallbackDefinition)
		: newInstance()
}

----
Used to pass error when actionListenerCallback is used with promises
----
struct actionListenerError = {
	token, exception
}

----
MqttCallback adapter

- see [http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttCallback.html](http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttCallback.html)

Enables an application to be notified when asynchronous events related to the client occur. 
Classes implementing this interface can be registered on both types of client: 
- IMqttClient.setCallback(MqttCallback) 
- and IMqttAsyncClient.setCallback(MqttCallback)
----
function mqttCallback = |messageArrivedCbk, deliveryCompleteCbk, connectionLostCbk| {

	let mqttCallbackDefinition = Adapter(): interfaces(["org.eclipse.paho.client.mqttv3.MqttCallback"])
		: implements("connectionLost", |this, throwableCause| {
				connectionLostCbk(throwableCause)
			})
		: implements("messageArrived", |this, stringTopic, mqttMessage| {
				messageArrivedCbk(stringTopic, mqttMessage)
			})		
		: implements("deliveryComplete", |this, token| {
				deliveryCompleteCbk(token)
			})	
		: definition()

	return AdapterFabric()
		: maker(mqttCallbackDefinition)
		: newInstance()
}

----
Mqtt helper, kind of class with tool-belt methods
----
struct mqttHelper = { _foo }

----
mqttHelper augmentations
----
augment mqttHelper {
----
return MqttConnectOptions

Holds the set of options that control how the client connects to a server.

usage:

	let options = mqttHelper(): getConnectOptions()

- see [http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttConnectOptions.html](http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttConnectOptions.html)
----	
	function getConnectOptions = |this| {
		let connOpts = MqttConnectOptions() # MqttConnectOptions
		connOpts: setCleanSession(true)
		return connOpts
	}
----
return MqttConnectOptions

Holds the set of options that control how the client connects to a server.

- see [http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttConnectOptions.html](http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttConnectOptions.html)
----	
	function getConnectOptions = |this, cleanSession| { # true or false
		let connOpts = MqttConnectOptions() # MqttConnectOptions
		connOpts: setCleanSession(cleanSession)
		return connOpts
	}
} 

----
Mqtt device structure

It's a decorator (or proxy ?) around MqttAsyncClient

`messageArrived`, `deliveryComplete` and `connectionLost` are references to the handler methods of the `MqttCallback` adapter

----
struct mqttDevice = { 
		id
	, topic
	,	content
	, broker
	, qos
	, connectOptions
	, messageArrived
	, deliveryComplete
	, connectionLost
	,	_client						#private member
}

----
mqttDevice augmentations
----
augment mqttDevice {

----
MqttAsyncClient factory
Used by

- `initialize` method
----
	function getMqttClient = |this| {
		let persistence = MemoryPersistence()
		let mqttClient = MqttAsyncClient(this: broker(): url(), this: id(), persistence) # MqttClient
		this: _client(mqttClient)

		this: messageArrived(|topic, message| -> null)
		this: deliveryComplete(|token| -> null)
		this: connectionLost(|error| -> null)

		return this
	}
----
This is the constructor of the mqtt device
You've to call it only after defining(setting) properties

- default value of `qos` is `0`
- `id` of the device is automatically generated
----
	function initialize = |this| {
		if this: qos() is null { this: qos(0) }
		this: id(MqttClient.generateClientId())
		this: getMqttClient()
		return this
	}
----
This is the constructor of the mqtt device
You've to call it only after defining(setting) properties

- default value of `qos` is `0`
- `id` of the device is a parameter of the constructor
----	
	function initialize = |this, clientId| {
		if this: qos() is null { this: qos(0) }
		this: id(clientId)
		this: getMqttClient()
		return this
	}
----
Set the mqtt callback of the device (MqttClient)
----
	function activateCallBacks = |this| {
		this: _client(): setCallback(mqttCallback(
			this: messageArrived(), 
			this: deliveryComplete(), 
			this: connectionLost()
		)) 
	}
----
Synchronous connection *(to be tested)*
----
	function syncConnect = |this| { # try catch?
		println("Connecting to broker: " + this: broker(): url())
		this: activateCallBacks()
		this: _client(): connect(this: connectOptions())        
		println("Connected")
		return this
	}
----
Asynchronous connection with actionListenerCallback
----
	function connect = |this, success, failed| { 
		println("Connecting to broker: " + this: broker(): url())
		this: activateCallBacks()
		this: _client(): connect(this: connectOptions(), null, actionListenerCallback(
			success,
			failed
		))

		return this
	}

----
Asynchronous connection returning a promise
----
	function connect = |this| {
		# define promise
	  return promise(): initialize(|resolve, reject| {
	    # doing something asynchronous
			this: connect( 
				|token| { # if success
					resolve(token)
				}, 
				|token, exception| { # if failed
				  reject(actionListenerError(token, exception))
				}
			)
	  })
	}	

----
Synchronous topic subscription *(to be tested)*
----
	function syncSubscribe = |this, topic| {
		this: _client(): subscribe(topic, this: qos())
		return this
	}

----
Asynchronous topic subscription with actionListenerCallback

see: [http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttAsyncClient.html#subscribe(java.lang.String[], int[], java.lang.Object, org.eclipse.paho.client.mqttv3.IMqttActionListener)](http://www.eclipse.org/paho/files/javadoc/org/eclipse/paho/client/mqttv3/MqttAsyncClient.html#subscribe(java.lang.String[], int[], java.lang.Object, org.eclipse.paho.client.mqttv3.IMqttActionListener))

TODO:

- subscribe to several topics
----
	function subscribe = |this, topic, success, failed| {
		this: _client(): subscribe(topic, this: qos(), null, actionListenerCallback(
			success,
			failed
		))
		return this
	}
----
Asynchronous topic subscription returning a promise
----
	function subscribe = |this, topic| {
		# define promise
	  return promise(): initialize(|resolve, reject| {
	    # doing something asynchronous
			this: subscribe(topic, 
				|token| { # if success
					resolve(token)
				}, 
				|token, exception| { # if failed
				  reject(actionListenerError(token, exception))
				}
			)
	  })

	}

----
Synchronous topic un-subscription *(to be tested)*

TODO:

- Asynchronous methods
----
	function syncUnsubscribe = |this, topic| {
		this: _client(): unsubscribe(topic)
		return this
	}

----
Synchronous publication of content property value to the current topic *(to be tested)*
----
	function syncPublish = |this| {

		println("Publishing message: " + this: content())
		let message = MqttMessage(this: content(): getBytes()) # MqttMessage
		message: setQos(this: qos())
		this: _client(): publish(this: topic(), message)
		println("Message published")
		return this
	}
----
Asynchronous publication of content property value to the current topic with actionListenerCallback
----
	function publish = |this, onSuccess, onFailure| {

		println("Publishing message: " + this: content())
		let message = MqttMessage(this: content(): getBytes()) # MqttMessage
		message: setQos(this: qos())
		this: _client(): publish(this: topic(), message, null, actionListenerCallback(
			onSuccess, onFailure
		))
		println("Message published")
		return this

	}
----
Asynchronous publication of content property value to the current topic returning a promise
----
	function publish = |this| {
		# define promise
	  return promise(): initialize(|resolve, reject| {
	    # doing something asynchronous
			this: publish( 
				|token| { # if success
					resolve(token)
				}, 
				|token, exception| { # if failed
				  reject(actionListenerError(token, exception))
				}
			)
	  })

	}
----
Synchronous disconnection *(to be tested)*
----
	function syncDisconnect = |this| {
		this: _client(): disconnect()
		println("Disconnected")
    java.lang.System.exit(0)
	}
----
Asynchronous disconnection with actionListenerCallback
----
	function disconnect = |this, onSuccess, onFailure| {
		this: _client(): disconnect(null, actionListenerCallback(
			onSuccess, onFailure
		))
	}
----
Asynchronous disconnection returning a promise
----
	function disconnect = |this| {
		# define promise
	  return promise(): initialize(|resolve, reject| {
	    # doing something asynchronous
			this: disconnect( 
				|token| { # if success
					resolve(token)
				}, 
				|token, exception| { # if failed
				  reject(actionListenerError(token, exception))
				}
			)
	  })
	}

} 

----
Mqtt Broker structure (helper/reference to the mqtt server)

Use:

----
struct broker = {
		protocol
	,	host
	, port
}
----
Broker augmentations
----
augment broker {
----
`url` method returns the url of the mqtt broker built from the broker structure properties
----
	function url = |this| -> this: protocol() + "://" + this: host() + ":" + this: port()
} 

