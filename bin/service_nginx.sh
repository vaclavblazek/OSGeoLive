#!/bin/sh
#############################################################################
#
# Purpose: This script will install nginx
#
#############################################################################
# Copyright (c) 2009-2018 Open Source Geospatial Foundation (OSGeo) and others.
#
# Licensed under the GNU LGPL.
#
# This library is free software; you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 2.1 of the License,
# or any later version.  This library is distributed in the hope that
# it will be useful, but WITHOUT ANY WARRANTY, without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details, either
# in the "LICENSE.LGPL.txt" file distributed with this software or at
# web page "http://www.fsf.org/licenses/lgpl.html".
#############################################################################

./diskspace_probe.sh "`basename $0`" begin
BUILD_DIR=`pwd`
####

# prevent default server symlink creation
mkdir -p /etc/nginx/sites-enabled
touch /etc/nginx/sites-enabled/default

apt-get install --yes nginx

service nginx stop

####
./diskspace_probe.sh "`basename $0`" end
