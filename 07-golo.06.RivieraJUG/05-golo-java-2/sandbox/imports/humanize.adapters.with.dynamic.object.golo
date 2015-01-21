module humanize.adapters.with.dynamic.object


function Adapter = {
  let adapterDefinition = DynamicObject(): definition(map[])

  adapterDefinition: define("interfaces", |this, arrayInterfaces| {
    this: definition(): put("interfaces", arrayInterfaces)
    return this
  })

  adapterDefinition: define("extends", |this, className| {
    this: definition(): put("extends", className)
    return this
  })

  adapterDefinition: define("implements", |this, methodName, closure| {
    if this: definition(): get("implements") is null {
      this: definition(): put("implements", map[])
    }
    this: definition(): get("implements"): put(methodName, closure)
    return this
  })

  adapterDefinition: define("overrides", |this, methodName, closure| {
    if this: definition(): get("overrides") is null {
      this: definition(): put("overrides", map[])
    }
    this: definition(): get("overrides"): put(methodName, closure)
    return this
  })

  return adapterDefinition
}