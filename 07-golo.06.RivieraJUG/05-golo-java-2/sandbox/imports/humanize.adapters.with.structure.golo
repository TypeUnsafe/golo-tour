module humanize.adapters.with.structure


struct Adapter = { definition }

augment Adapter {
  function interfaces = |this, arrayInterfaces| {
    if this: definition() is null { this: definition(map[]) }
    this: definition(): put("interfaces", arrayInterfaces)
    return this
  }
  function extends = |this, className| {
    if this: definition() is null { this: definition(map[]) }
    this: definition(): put("extends", className)
    return this
  }
  function implements = |this, methodName, closure| {
    if this: definition(): get("implements") is null {
      this: definition(): put("implements", map[])
    }
    this: definition(): get("implements"): put(methodName, closure)
    return this
  }
  function overrides = |this, methodName, closure| {
    if this: definition(): get("overrides") is null {
      this: definition(): put("overrides", map[])
    }
    this: definition(): get("overrides"): put(methodName, closure)
    return this
  }
} 