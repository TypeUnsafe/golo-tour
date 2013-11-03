module use_ranges_and_times

function main = |args| {
  
  # 1, 2 (end exclusive like python)
  range(1,3): each(|el|->println(el))

  # 5, 7, 9
  range(5,10): 
    incrementBy(2): 
    each(|el|->println(el))

  # times
  5:times(|i|{
    println(">>> " + i)
  })

}