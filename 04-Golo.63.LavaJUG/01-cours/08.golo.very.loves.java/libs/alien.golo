module org.k33g.alien.adapters

function methods = -> DynamicObject()

struct adapter = { 
    interfaces
  , extends
  , overrided
  , implemented
  , conf
}

augment org.k33g.alien.adapters.types.adapter {
  function overrides = |this, mets|{
    this:overrided(map[])
    mets:properties():each(|member|{
      this:overrided():add(member: getKey(), member: getValue())
    })
    return this
  }
  function implements = |this, mets|{
    this:implemented(map[])
    mets:properties():each(|member|{
      this:implemented():add(member: getKey(), member: getValue())
    })
    return this
  }
  function make = |this| {
    this:conf(map[])
    if this:interfaces() isnt null {
      this:conf():add("interfaces", this:interfaces())
    }
    if this:extends() isnt null {
      this:conf():add("extends", this:extends())
    }
    if this:overrided() isnt null {
      this:conf():add("overrides", this:overrided())
    }
    if this:implemented() isnt null {
      this:conf():add("implements", this:implemented())
    }
    return AdapterFabric(): maker(this:conf())
  }
}

function Adapter = -> adapter()