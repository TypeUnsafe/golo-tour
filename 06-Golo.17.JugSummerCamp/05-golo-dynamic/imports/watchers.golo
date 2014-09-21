module watchers

import gololang.concurrent.workers.WorkerEnvironment

function watch = |directory, callBack| {
  let workerEnvironment = WorkerEnvironment.builder(): withCachedThreadPool()
  let folder_worker = workerEnvironment: spawn(|message| {

      # http://docs.oracle.com/javase/tutorial/essential/io/notification.html#register

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
          #todo(watchEvent, folder)
          println("=> " + watchEvent: kind() + " " + watchEvent: context() + " " + folder)
          callBack()
        })
        key: reset()
        key = watchService: take()

      }
    })

    folder_worker: send("go")

}