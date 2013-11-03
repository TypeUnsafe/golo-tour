module some_tests

import acme.Toon
import acme.Elmira
import tests

function main = |args| {
  
  That("Toon:name() is a string", 
    Toon("Buster"):name() )
    :isAString(
        |res|-> println("Good : " + res)
      , |res|-> raise("Bad")
    )

  That("Toon:name() of Buster == Buster", 
    Toon("Buster"):name() )
    :isEqualTo("Buster"
      , |res|-> println("Good : " + res)
      , |res|-> raise("Bad")
    )

  That("Toon:scream() does not return a string", 
    Toon("Babs"):scream() )
    :isNotAString(
        |res|-> println("Good")
      , |res|-> raise("Bad")
    )

  That("Toon:scream() return null",
    Toon("Elmira"):scream() )
    :isNull(
        |res|-> println("Good !!! scream() is null")
      , |res|-> raise("Bad : this is not null")
    )

  That("Toon:name() is an integer", Toon("Taz"):name() )
    :isAnInteger(
        |res|-> println("Good : " + res)
      , |res|-> raise("Bad : " + res + " is not an integer")
    )


}