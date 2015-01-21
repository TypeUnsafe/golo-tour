module timer

struct timer = {
  begin, end, duration
}
augment timer {
  function start = |this| {
    this: begin(java.lang.System.currentTimeMillis())
    return this
  }
  function start = |this, callback| {
    this: begin(java.lang.System.currentTimeMillis())
    callback(this)
    return this
  }
  function stop = |this| {
    this: end(java.lang.System.currentTimeMillis())
    this: duration(this: end() - this: begin())
    return this
  }
  function stop = |this, callback| {
    this: end(java.lang.System.currentTimeMillis())
    this: duration(this: end() - this: begin())
    callback(this)
    return this
  }
} 


function main = |args| {
  #my timer

  let t = timer(): start(|self| {
    Thread.sleep(500_L)
  }): stop(|self|{
    println(self: duration() + " ms")
  })

}

