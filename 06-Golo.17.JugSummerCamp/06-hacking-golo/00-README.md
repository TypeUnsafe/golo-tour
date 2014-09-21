#un hack java :

//Predefined.java
public static String currentDir() throws IOException {
  return new File(".").getCanonicalPath();
}

#un hack golo : 

augment gololang.concurrent.async.Promise {
  function initialize = |this, closure| {
    closure(|data| -> this: set(data), |err| -> this: fail(err))
    return this: future()
  }
}

#Compiler Golo

rake special:bootstrap
