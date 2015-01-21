module lestestscestbien

import acme
import molossol

# write a new matcher "Contain"
# ...


function main = |args| {

  # this is a suite (set of specifications)
  describe("Elmira is a toon that loves other toons too much", {

    let Elmira = Toon("Elmira")

    # this is a specification (set of expectations)
    it("Elmira name is 'Elmira'", {

      # this an expectation (= matcher)
      expect(Elmira: getName()): toEqual("Elmira")

    })

    it("Elmira loves Buster", {
      
      let Buster = Toon("Buster")

      expect(Elmira: hug(Buster))
        : toEqual(Elmira: name() + " <3 " + Buster: name())

      # try the new matcher
      expect(Elmira: hug(Buster))
        : toContain("<<3")

    })

  })

}