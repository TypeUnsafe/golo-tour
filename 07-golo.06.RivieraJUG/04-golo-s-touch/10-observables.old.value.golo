module observable_and_old_value

struct Noticeable = { 
  currentAndOldValues,
  observable
}

augment Noticeable {

  function initialize = |this, initialValue| {
    this: currentAndOldValues(vector[initialValue, null])  # current, old
    this: observable(Observable(initialValue))
    return this
  }

  function setValue = |this, value| {
    this: currentAndOldValues()
      : set(1, this: currentAndOldValues(): get(0))
    this: currentAndOldValues(): set(0, value)
    this: observable(): set(value)
  }

  function old = |this| -> this: currentAndOldValues(): get(1)

  function addObserver = |this, observer| {
    this: observable(): onChange(observer)
  }
} 

function main = |args| {

  let john = Noticeable() : initialize("john")
    
  john: addObserver(|value| {
    println("First: new = " + value + " old = " + john: old())
  })
  john: addObserver(|value| {
    println("Second: new = " + value + " old = " + john: old())
  })

  john : setValue("John Doe")
  john : setValue("JOHN DOE")

}