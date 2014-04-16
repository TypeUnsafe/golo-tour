module redis_tests

import redis #(cf libs/redis.golo)

function main = |args| {

  let redis = Redis(): connect()

  redis: save("superhero:peter", map[
    ["firstName", "Peter"],
    ["lastName", "Parker"]
  ])

  redis: save("superhero:clark", map[
    ["firstName", "Clark"],
    ["lastName", "Kent"]
  ])

  println(redis: fetch("superhero:peter"))
  println(redis: fetch("superhero:clark"))

  redis: all("superhero:*"): each(|hero|{
    println("- " + hero)
  })

}
