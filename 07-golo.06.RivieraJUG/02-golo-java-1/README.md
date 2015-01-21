
  let mongocli = MongoClient("localhost", 27017)
  let db = mongocli: getDB("comics")
  let coll = db: getCollection("characters")
  let q = QueryBuilder(): text("iron"): get()

  coll: find(q): each(|doc| -> println(doc: get("name")))



