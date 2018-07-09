#!/bin/sh
#############################################################################
#
# Purpose: This script will install QGIS including Python and GRASS support,
#
#############################################################################
# Copyright (c) 2009-2016 The Open Source Geospatial Foundation and others.
# Licensed under the GNU LGPL version >= 2.1.
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


VTS_PACKAGES="vts-tools vts-vtsd vts-mapproxy"

if [ -z "$USER_NAME" ] ; then
   USER_NAME="user"
fi
USER_HOME="/home/$USER_NAME"

TMP_DIR=/tmp/build_qgis

if [ ! -d "$TMP_DIR" ] ; then
   mkdir "$TMP_DIR"
fi
cd "$TMP_DIR"

apt-get -q update

#Install packages
## 23feb14 fix for QGis "can't make bookmarks"
apt-get --assume-yes install ${VTS_PACKAGES}

if [ $? -ne 0 ] ; then
   echo 'ERROR: Package install failed! Aborting.'
   exit 1
fi

apt-get --assume-yes remove --purge ${VTS_PACKAGES}

if [ $? -ne 0 ] ; then
   echo 'ERROR: Package purge failed! Aborting.'
   exit 1
fi
