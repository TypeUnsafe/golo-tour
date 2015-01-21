module humans

struct Human = {
  firstName, lastName, _age
}

augment Human {
  function getAge = |this| {
    return this: _age()
  }
} 