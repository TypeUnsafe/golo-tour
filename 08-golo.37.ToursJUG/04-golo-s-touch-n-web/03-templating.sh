#!/bin/sh
#

RC=1
#trap "echo CTRL-C was pressed" 2
trap "exit 1" 2
while [ $RC -ne 0 ] ; do
   golo golo --classpath jars/*.jar --files imports/*.golo 03-templating.golo
   RC=$?
done
