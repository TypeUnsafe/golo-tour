module mongoo

import com.mongodb.MongoClient
import com.mongodb.MongoException
import com.mongodb.WriteConcern
import com.mongodb.DB
import com.mongodb.DBCollection
import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import com.mongodb.DBCursor
import com.mongodb.ServerAddress
import org.bson.types.ObjectId

----
  let mongocli = mongo("database", "localhost", 27017): initialize()

  let humanModel = mongocli: modelOf("humans")

  http://api.mongodb.org/java/2.12/com/mongodb/QueryBuilder.html
  http://api.mongodb.org/java/2.11.4/com/mongodb/DBCursor.html
  http://api.mongodb.org/java/2.11.4/com/mongodb/QueryBuilder.html
  http://stackoverflow.com/questions/14314692/simple-query-in-mongodb-in-java  
----
struct mongo = { 
  _mongoClient,
  _db
}

augment mongo {
  function initialize = |self, databaseName, host, port| {
    #TODO: verify connection
    self: _mongoClient(MongoClient(host, port))
    self: _db(self: _mongoClient(): getDB(databaseName))
    return self
  }

  function db = |self| -> self: _db()
  # returns a com.mongodb.DBCollection
  function collection = |self, collectionName| {
    let dbCollection = self: _db(): getCollection(collectionName)
    #let newModel = mongoModel(dbCollection, BasicDBObject())

    let newCollection = mongoCollection(
      dbCollection,
      null, null, null
    )
    return newCollection
  }

  function model = |self, collectionName| {
    let dbCollection = self: _db(): getCollection(collectionName)
    let newModel = mongoModel(dbCollection, BasicDBObject())
    return newModel
  }

} 


struct mongoCollection = {
  _collection,
  skip,
  limit,
  sort
}

augment mongoCollection {
  function options = |self, cursor| {
    if self: sort() isnt null {
      cursor: sort(BasicDBObject(self: sort(): get(0), self: sort(): get(1)))
      self: sort(null)
    }
    if self: skip() isnt null {
      cursor: skip(self: skip()): limit(self: limit())
      self: skip(null): limit(null)
    }
    return cursor    
  }
  # helpers :
  function cursorToListOfMaps = |self, cursor| { # return list of HashMaps
    let models = list[]
    cursor: each(|doc| {
      let map = doc: toMap()
      let id = doc: getObjectId("_id"): toString()
      map: put("_id", id)
      models: add(map)
    })
    return models
  }
  # helpers :
  function cursorToList = |self, cursor| { # return list of MongoModels
    let models = list[]
    cursor: each(|doc| {
      let newModel = mongoModel(self: _collection(), BasicDBObject())
      newModel: fromMap(doc: toMap())
      models: add(newModel)
    })
    return models
  }  

  function fetch = |self| {
    let cursor = self: _collection(): find() # lazy fetch
    self: options(cursor)
    return self: cursorToList(cursor)
  }

  function fetchMaps = |self| {
    let cursor = self: _collection(): find() # lazy fetch
    self: options(cursor)
    return self: cursorToListOfMaps(cursor)   
  }


  # find models (value objects)
  #coll: find("firstName", "John")
  function find = |self, fieldName, value| {
    let query = BasicDBObject(fieldName, value)
    let cursor = self: _collection(): find(query)
    self: options(cursor)
    return self: cursorToList(cursor)
  }

  function findMaps = |self, fieldName, value| {
    let query = BasicDBObject(fieldName, value)
    let cursor = self: _collection(): find(query)
    self: options(cursor)
    return self: cursorToListOfMaps(cursor)
  }

  #coll: like("firstName", ".*o.*")
  function like = |self, fieldName, value| {
    let query = BasicDBObject(fieldName, java.util.regex.Pattern.compile(value))
    let cursor = self: _collection(): find(query)
    self: options(cursor)
    return self: cursorToList(cursor)
  }

  function likeMaps = |self, fieldName, value| {
    let query = BasicDBObject(fieldName, java.util.regex.Pattern.compile(value))
    let cursor = self: _collection(): find(query)
    self: options(cursor)
    return self: cursorToListOfMaps(cursor)
  }

  function query = |self, query| {
    # query is a com.mongodb.QueryBuilder
    let cursor = self: _collection(): find(query)
    self: options(cursor)
    return self: cursorToList(cursor)
  }
  function queryMaps = |self, query| {
    # query is a com.mongodb.QueryBuilder
    let cursor = self: _collection(): find(query)
    self: options(cursor)
    return self: cursorToListOfMaps(cursor)
  }  
  # let query = QueryBuilder.start("pseudo"): notEquals("@sam"): get()
  # buddies: query(query)

}


struct mongoModel = {
  _collection,
  _basicDBObject
}

augment mongoModel {
  function id = |self| -> self: _basicDBObject(): getObjectId("_id"): toString()

  function field = |self, fieldName, fieldValue| {
    self: _basicDBObject(): put(fieldName, fieldValue)
    return self    
  }
  function field = |self, fieldName| -> self: _basicDBObject(): get(fieldName) 

  function fields = |self, fieldsMap| {
    #TODO
  }
  
  function insert = |self| {
    self: _collection(): insert(self: _basicDBObject())
    return self
  }

  function update = |self| {
    let id = self: _basicDBObject(): get("_id")
    self: _basicDBObject(): removeField("_id")
    let searchQuery = BasicDBObject(): append("_id", ObjectId(id))
    self: _collection(): update(searchQuery, self: _basicDBObject())
    self: _basicDBObject(): put("_id", ObjectId(id))
    return self    
  }

  function fetch = |self, id| {
    let searchQuery = BasicDBObject(): append("_id", ObjectId(id))
    #self: _basicDBObject(): putAll(self: _collection(): findOne(searchQuery))
    self: _collection(): find(searchQuery): each(|doc| {
      self: _basicDBObject(): putAll(doc)
    })
    return self
  }
  function fetch = |self| {
    return self: fetch(self: id())
  }
  function remove = |self, id| {
    let searchQuery = BasicDBObject(): append("_id", ObjectId(id))
    let doc = self: _collection(): find(searchQuery): next()
    self: _basicDBObject(): putAll(doc)
    self: _collection(): remove(doc)
    return self
  }
  function remove = |self| {
    return self: remove(self: id())
  }
  function toMap = |self| {
    let map = self: _basicDBObject(): toMap()
    map: put("_id", self: id())
    return map
  }
  function fromMap = |self, fieldsMap| {
    self: _basicDBObject(BasicDBObject(fieldsMap))
    return self
  }
  function toJsonString = |self| -> JSON.stringify(self: toMap())

  function fromJsonString = |self, jsonString| {
    let bo = BasicDBObject()
    bo: putAll(JSON.parse(jsonString))
    self: _basicDBObject(bo)
    return self
  }
}


