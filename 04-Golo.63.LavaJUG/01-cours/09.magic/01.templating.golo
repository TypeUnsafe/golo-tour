module templating

function template = ->
"""
<%@params humans %>
<b>Humans List</b>
<ul><% foreach human in humans { %>
	<li><%= human:id() %> <%= human:name() %></li><% } %>
</ul>
"""

function main = |args| {
	let humans = list[
      DynamicObject():id("001"):name("Bob Morane")
    , DynamicObject():id("002"):name("John Doe")
    , DynamicObject():id("003"):name("Jane Doe")
  ]

  # 1
  let output = gololang.TemplateEngine(): compile(template())
  
  println(output(humans))

  # 2
  humans:add(DynamicObject():id("004"):name("Mickey Mouse"))
  
  println(output(humans))
}