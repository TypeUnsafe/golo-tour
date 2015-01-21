module lestestscestbien

import acme
import http
import molossol

function main = |args| {

  describe("Test get request http://localhost:9000/books", {

    it("Response code is 200", {

      expect(
        getHttp("http://localhost:9000/books", JSON()): code()
      ): toEqual(200)

    })

  })

}