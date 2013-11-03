module models.humans

import redis

function Human = -> DynamicObject()
	:mixin(redis.Model())
    :kind("human")
    :db("localhost",6379)
    :keyFields(["firstName", "lastName"])