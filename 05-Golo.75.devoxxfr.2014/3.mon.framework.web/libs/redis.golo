module redis

import redis.clients.jedis.Jedis

# properties
struct redis = {
    host
  , port
  , db 
}
# methods
augment redis {
  function connect = |this| {
    this: db(Jedis(this: host(), this: port()))
    return this
  }
  function save = |this, key, fields| -> this: db(): hmset(key, fields)
  function fetch = |this, key| -> this: db(): hgetAll(key)
  function allKeys = |this, qKey| -> this: db(): keys(qKey)
  function all = |this, qKey| -> 
    this: allKeys(qKey): map(|key| -> this: fetch(key)) # java.util.HashSet
  function delete = |this, key| -> this: db(): del(key)
}
# constructor
function Redis = { # with default parameters
  return redis(): host("localhost"): port(6379)
}
