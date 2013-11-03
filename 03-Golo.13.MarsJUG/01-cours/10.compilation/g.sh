#!/bin/sh
# Copyright (c) 2013 Philippe Charrière aka @k33g_org
#
# All rights reserved. No warranty, explicit or implicit, provided.
#

golo compile --output classes 42.golo
cd classes/
jar -cf 42.jar org/fortytwo/H2G2.class

