module console

function console = {
  let terminal = DynamicObject():escCode("\u001B[")

  terminal:reset(|this| -> this:print(this:escCode()+"0m"))

  terminal: blink(|this| -> this:print(this:escCode()+"5m"))

  terminal: black(|this| -> this:print(this:escCode()+"30m"))

  terminal: white(|this| -> this:print(this:escCode()+"37m"))

  terminal: red(|this| -> this:print(this:escCode()+"31m"))

  terminal: green(|this| -> this:print(this:escCode()+"32m"))

  terminal: yellow(|this| -> this:print(this:escCode()+"33m"))

  terminal: blue(|this| -> this:print(this:escCode()+"34m"))

  terminal: pos(|this, row, col| ->
    this:print(this:escCode()+"%s;%sf":format(row:toString(), col:toString()))
  )

  terminal: home(|this| -> this:pos(0,0))
  
  terminal: clear(|this| -> this:print(this:escCode()+"2J"))

  # don't change cursor position
  terminal: eraseLine(|this| -> this:code(this:escCode()+"2K"))

  terminal: print(|this, message| {
    print(message)
    return this
  })

  terminal:home()
  return terminal 

}

