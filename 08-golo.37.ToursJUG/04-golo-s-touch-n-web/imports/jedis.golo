module kiss.jedis

import redis.clients.jedis.Jedis
import redis.clients.jedis.ScanParams
import redis.clients.jedis.ScanParams.SCAN_POINTER_START

struct model = {
  db,
  type,
  attributes,
  state
}
# generic model augmentation
augmentation modelAbilities = {
  function field = |this, attrName| {
    return this: attributes(): get(attrName)
  }
  function field = |this, attrName, value| {
    this: attributes(): put(attrName, value)
    return this
  }
  function id = |this| -> this: field("id")
  function id = |this, value| -> this: field("id", value)

  function toJson = |this| -> JSON.stringify(this: attributes())

  function fromJson = |this, jsonString| -> this: attributes(JSON.parse(jsonString))

  # tojson / fromjson
}

# specific model augmentation
augmentation redisModelSyncAbilities = {
  function save = |this| {
    this: db(): set(this: id() orIfNull uuid(), JSON.stringify(this: attributes()))
    this: db(): sadd(this: type(), this: id())
    this: state(["saved", System.currentTimeMillis()])
    return this
  }
  function isSaved = |this| {
    if this: state(): get(0): equals("saved") { return true }
    return false
  }
  function fetch = |this| {
    this: attributes(JSON.parse(this: db(): get(this: id())))
    this: state(["fetched", System.currentTimeMillis()])
    return this
  }
  function fetch = |this, key| {
    this: attributes(JSON.parse(this: db(): get(key)))
    this: state(["fetched", System.currentTimeMillis()])
    return this
  }
  function isFetched = |this| {
    if this: state(): get(0): equals("fetched") { return true }
    return false
  }
  # delete
}
#augment model
augment model with modelAbilities, redisModelSyncAbilities

# model constructor
function Model = |db, type| -> model(): type(type): db(db): attributes(map[]) #state is null

struct collection = {
  model
}

augmentation redisCollectionSyncAbilities = {

  function getAll = |this| {
    let models = list[]

    this: model(): db()
      : smembers(this: model(): type())
      : each(|key| -> models: add(this: model(): copy(): fetch(key)))

    return models
  }

  function getAll = |this, filterKey| {
    let params = ScanParams()
    let models = list[]
    params: `match(filterKey) #` -> because match is a golo keyword
    this: model(): db()
      : sscan(this: model(): type(), SCAN_POINTER_START(), params)
      : getResult()
      : each(|key| -> models: add(this: model(): copy(): fetch(key)))

    return models
  }

  function getAllToJson = |this| {
    let models = list[]

    this: model(): db()
      : smembers(this: model(): type())
      : each(|key| -> models: add(this: model(): fetch(key): attributes()))

    return JSON.stringify(models)
  }

  function getAllToJson = |this, filterKey| {
    let params = ScanParams()
    let models = list[]
    params: `match(filterKey) #` -> because match is a golo keyword
    this: model(): db()
      : sscan(this: model(): type(), SCAN_POINTER_START(), params)
      : getResult()
      : each(|key| -> models: add(this: model(): fetch(key): attributes()))

    return JSON.stringify(models)
  }
}

augment collection with redisCollectionSyncAbilities

function Collection = |model| -> collection(): model(model)


