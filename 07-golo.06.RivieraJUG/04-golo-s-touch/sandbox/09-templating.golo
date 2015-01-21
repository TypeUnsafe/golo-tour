module templating_demo

function template = ->
"""
<%@params humans %>
<b>Humans List</b>
<ul><% foreach human in humans { %>
  <li><%= human:id() %> <%= human:name() %></li><% } %>
</ul>
"""

function main = |args| {
  
  let humansList = list[
      DynamicObject():id("001"):name("John Doe")
    , DynamicObject():id("002"):name("Jane Doe")
  ]

  let output = gololang.TemplateEngine(): compile(template())
  
  println(output(humansList))

  humansList:add(DynamicObject():id("003"):name("Bob Morane"))
  
  println(output(humansList))
}