#!/bin/sh
# Copyright (c) 2013 Philippe Charrière aka @k33g_org
#
# All rights reserved. No warranty, explicit or implicit, provided.
#

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_12.jdk/Contents/Home
export GOLO_HOME=/Users/k33g_org/Dropbox/Public/golo-lang/target/golo-0-preview5-SNAPSHOT-distribution/golo-0-preview5-SNAPSHOT/bin

echo "1- loading jars"
#FIND JARS
JARS=""
FILES="$(find $1 -name '*.jar')"
for jar in $FILES
do
	JARS="$JARS$PWD/$jar:"
	echo "--> $jar"
done

export CLASSPATH_PREFIX=${CLASSPATH_PREFIX}:"$JARS"


echo "2- loading Golo Libraries"
#FIND GOLO LIBRARIES
LIBS=""
FILES="$(find $1 -name '*.golo')"
for gf in $FILES
do
	LIBS="$LIBS $gf"
	echo "--> $gf"
done

echo "3- running $2"
echo 

$GOLO_HOME/golo golo --files $LIBS $2

