module client

function syncGet = |url, success, error| {

  try {
    let obj = java.net.URL(url) # URL obj
    let con = obj:openConnection() # HttpURLConnection con (Cast?)
    #optional default is GET
    con:setRequestMethod("GET")

    #con:setRequestProperty("Content-Type", "text/plain; charset=utf-8")
    con:setRequestProperty("Content-Type", "application/json; charset=utf-8")

    let responseCode = con:getResponseCode() # int responseCode
    let responseMessage = con:getResponseMessage() # String responseMessage

    let responseText = java.util.Scanner(con:getInputStream(), "UTF-8"):useDelimiter("\\A"):next() # String responseText

    success(responseCode, responseMessage, responseText)

  } catch(e) {
    error(e)
  }
}

function main = |args| {

  syncGet("http://localhost:8081/hello/world", 
    |code, message, text| {
      println("code: " + code)
      println("message: " + message)
      println("text: " + text)

      println(JSON.parse(text))

    }, 
    |error| -> println(error)
  )
}



