module the_others

# Tuple   gololang.Tuple          tuple[1, 2, 3], or simply [1, 2, 3]
# Array   java.lang.Object[]      array[1, 2, 3]
# Vector  java.util.ArrayList     vector[1, 2, 3]
# Set     java.util.LinkedHashSet set[1, 2, 3]


function main = |args| {
  let t = tuple["3", 1]
  println(t)
}