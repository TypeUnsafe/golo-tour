module kiss.mongo

import com.mongodb.MongoClient
import com.mongodb.BasicDBObject
import org.bson.types.ObjectId

struct model = {
  collection,
  basicDBObject
}

augment model {

  function field = |this, name, value| {
    this: basicDBObject(): put(name, value)
    return this
  }

  function field = |this, name| -> this: basicDBObject(): get(name)

  function id = |this, value| -> this: field("_id", value)

  function id = |this| -> this: field("_id")

  function save = |this| {
    let searchQuery = BasicDBObject(): append("_id", this: id())
    let doc = this: collection(): find(searchQuery)
    try {
      if doc: hasNext() is false {
        this: collection(): insert(this: basicDBObject())
      } else {
        this: collection(): update(searchQuery, this: basicDBObject())
      }
    } finally { doc: close() }
    return this
  }

  function fetch = |this| {
    let searchQuery = BasicDBObject(): append("_id", this: id())
    this: collection(): find(searchQuery): each(|doc| {
      this: basicDBObject(): putAll(doc)
    }): close()

    return this
  }

  function exists = |this| {
    let searchQuery = BasicDBObject(): append("_id", this: id())
    let doc = this: collection(): find(searchQuery)
    try { return doc: hasNext() } finally { doc: close() }
  }

  function remove = |this| {
    let searchQuery = BasicDBObject(): append("_id", this: id())
    let doc = this: collection(): find(searchQuery)
    try { if doc: hasNext() { this: collection(): remove(doc) } } finally { doc: close() }
    return this
  }

  function toJson = |this| -> JSON.stringify(this: basicDBObject())

  function fromJson = |this, jsonString| {
    let bo = BasicDBObject()
    bo: putAll(JSON.parse(jsonString: toString()))
    this: basicDBObject(bo)
    return this
  }

}

function Model = |mongoCollection| {
  return model(mongoCollection, BasicDBObject())
}

struct collection = {
  model
}

augment collection {

  function fetch = |this| {
    let models = list[]
    let cursor = this: model(): collection(): find()
    try {
      cursor: each(|doc| {
        models: add(this: model(): copy(): basicDBObject(doc))
      })
      return models
    } finally { cursor: close() }
  }

  function fetchToJson = |this| {
    let models = list[]
    let cursor = this: model(): collection(): find()
    try {
      cursor: each(|doc| {
        models: add(doc)
      })
      return JSON.stringify(models)
    } finally { cursor: close() }
  }

}

function Collection = |model| -> collection(): model(model)



