#!/bin/sh
#############################################################################
#
# Purpose: This script will install VTS insfrastructure
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

apt-get -q update

# #Install packages
# apt-get --assume-yes install dpkg-dev

# WORKDIR=/tmp/melown-bionic
# REPODIR=/usr/local/share/melown-bionic

# # fetch packages
# mkdir -p ${WORKDIR}
# (
#     cd ${WORKDIR}
#     wget --accept-regex "\.deb$" --recursive -l 1 -nd -np \
#          http://cdn.melown.com/packages/repos/melown-bionic/

#     files=$(ls -1 *.deb | grep -v -- "-dbg" | sort -V | \
#                    awk 'BEGIN {FS="_"} /\.deb$/ {packages[$1]=$0} END {for (package in packages) { print packages[package] }}')


#     # build repository
#     mkdir -p ${REPODIR}
#     mv ${files} ${REPODIR}
#     cd ${REPODIR}
#     dpkg-scanpackages . /dev/null > Packages
#     gzip --keep --force -9 Packages

#     # build a release file
#     cat > Release <<EOF
# Origin: Melown Technologies SE
# Label: Melown Technologies SE
# Suite: melown-bionic-local
# Codename: melown-bionic-local
# Architectures: all i386 amd64
# EOF

#     echo -e "Date: `LANG=C date -Ru`" >> Release

#     # Release must contain MD5 sums of all repository files (in a simple repo
#     # just the Packages and Packages.gz file)s
#     echo -e 'MD5Sum:' >> Release
#     printf ' '$(md5sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
#     printf '\n '$(md5sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release

#     # Release must contain SHA256 sums of all repository files (in a simple repo
#     # just the Packages and Packages.gz files)
#     echo -e '\nSHA256:' >> Release
#     printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
#     printf '\n '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release

#     echo "deb [trusted=yes] file:${REPODIR} ./" \
#          > /etc/apt/sources.list.d/melown-bionic-local.list
# )
# rm -rf ${WORKDIR}


VTS_PACKAGES="vts-registry vts-tools vts-vtsd vts-mapproxy vts-mapproxy-tools vts-backend"

apt-get -q update

#Install packages
apt-get --assume-yes install ${VTS_PACKAGES}

if [ $? -ne 0 ] ; then
   echo 'ERROR: Package install failed! Aborting.'
   exit 1
fi

# remove them now
apt-get --assume-yes remove --purge ${VTS_PACKAGES}

if [ $? -ne 0 ] ; then
   echo 'ERROR: Package purge failed! Aborting.'
   exit 1
fi

# remove vts user
deluser vts
delgroup vts

# needed by grass+gdal
echo "/usr/lib/grass74/lib" > /etc/ld.so.conf.d/gdass.conf
ldconfig
