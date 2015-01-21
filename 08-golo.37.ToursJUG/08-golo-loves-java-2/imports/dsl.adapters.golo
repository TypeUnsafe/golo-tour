module dsl.adapters

import gololang.Adapters


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