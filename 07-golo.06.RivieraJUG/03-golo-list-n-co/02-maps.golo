module maps_demo

# = java.util.LinkedHashMap
# get, each, filter

function main = |args| {
  
  let books = map[
      [1, "A Princess of Mars"]
    , [2, "The Gods of Mars"]
    , [3, "The Chessmen of Mars"]
  ]

  println(books: filter(|key, value| -> value: startsWith("The")): get(3))

  #books: each(|key, value| -> println(key + " " + value))
}