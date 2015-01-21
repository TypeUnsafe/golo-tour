module template_strings

import gololang.TemplateEngine

# define template
function human = ->
"""
<%@params human %>
<b><%= human: name() %></b>
<b><%= human: land() %></b>
"""


function main = |args| {
  
  # compile template
  let t = TemplateEngine(): compile(human())

  # call compiled template
  println(t(DynamicObject()
          : name("Bob Morane")
          : land("US")))


}