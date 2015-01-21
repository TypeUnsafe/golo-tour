module humanize.adapters.with.decorators

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
  function class = |this| {
    return AdapterFabric(): maker(this: definition())
  }
} 

function extends = |className| {
  return |func| {
    return |adapter| {
      adapter: extends(className)
      return func: invokeWithArguments(adapter)
    }
  }
}

function interfaces = |arrayInterfaces| {
  return |func| {
    return |adapter| {
      adapter: interfaces(arrayInterfaces)
      return func: invokeWithArguments(adapter)
    }
  }
}

function implements = |methodName, closure| {
  return |func| {
    return |adapter| {
      adapter: implements(methodName, closure)
      return func: invokeWithArguments(adapter)
    }
  }
}

function overrides = |methodName, closure| {
  return |func| {
    return |adapter| {
      adapter: overrides(methodName, closure)
      return func: invokeWithArguments(adapter)
    }
  }
}