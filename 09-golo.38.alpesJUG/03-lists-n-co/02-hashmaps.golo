module main


function main = |args| {
  
  let books = map[
      ["001", "A Princess of Mars"]
    , ["002", "The Gods of Mars"]
    , ["003", "The Chessmen of Mars"]
  ]

  books: each(|key, value| -> println(key+" "+ value))
  

}