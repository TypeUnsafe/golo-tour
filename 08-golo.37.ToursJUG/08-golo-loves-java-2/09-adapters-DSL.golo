module dsl

import gololang.Adapters

function main = |args| {

  let carbonCopy = list[]
  let arrayListAdapter = Adapter()
    : extends("java.util.ArrayList")
    : overrides("*", |super, name, args| {
        if name == "add" {
          if args: length() == 2 {
            carbonCopy: add(args: get(1))
          } else {
            carbonCopy: add(args: get(1), args: get(2))
          }
        }
        return super: spread(args)
      })

  let list = arrayListAdapter: newInstance()
  list: add("bar")
  list: add(0, "foo")
  list: add("baz")

  println(carbonCopy)
  println(list)
}





