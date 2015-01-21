----
TODO: documentation

----
module io.connectedworkers.toolbelt.files.helper

import gololang.concurrent.workers.WorkerEnvironment

----
watcher structure: keep an eye on files modifications

		let sentry = watcher(): directory("plugins")
			: callBack(|watchEvent, folderName|{ 
					# foo
				})
----
struct watcher = { 
	directory,
	callBack,
	workerEnvironment # optional
}
----
watcher augmentations

		sentry: supervise()
----
augment watcher {
----
Start watching ...

See: [http://docs.oracle.com/javase/tutorial/essential/io/notification.html#register](http://docs.oracle.com/javase/tutorial/essential/io/notification.html#register)

----	
	function supervise = |this, message| {
		let directory = this: directory()
		let callBack = this: callBack()
		if this: workerEnvironment() is null {
			this: workerEnvironment(WorkerEnvironment.builder(): withCachedThreadPool())
		}
		let workerEnvironment = this: workerEnvironment()

	  let folder_worker = workerEnvironment: spawn(|message| {
	  		if message isnt null {
	  			println(message)
	  		}

	      # Folder we are going to watch / folder type: Path
	      let folder = java.nio.file.Paths.get(java.io.File( "." ): getCanonicalPath()+"/"+directory)

	      # Create a new Watch Service
	      let watchService = java.nio.file.FileSystems.getDefault(): newWatchService()

	      # Register events
	      folder: register(watchService,
	          java.nio.file.StandardWatchEventKinds.ENTRY_CREATE(),
	          java.nio.file.StandardWatchEventKinds.ENTRY_MODIFY(),
	          java.nio.file.StandardWatchEventKinds.ENTRY_DELETE())

	      # Get the first event before looping / key type: WatchKey
	      var key = watchService: take()

	      while key isnt null {

	        key: pollEvents(): each(|watchEvent| {
	          callBack(watchEvent, folder)
	        })
	        key: reset()
	        key = watchService: take()

	      }
	    })

	  folder_worker: send(message)
	  return this
	}
} 

----
This main method allows tests
----
function main = |args| {
	
	# watcher
	let sentry = watcher(): directory("tmp")
		: callBack(|watchEvent, folderName|{ 
				println("=> " + 
					watchEvent: kind() + " " + 
					watchEvent: context() + " " + 
					folderName
				)
			})
		: supervise("Supervising ...")
	
}



