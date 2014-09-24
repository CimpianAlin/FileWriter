#!/bin/sh
#
# This file is protected by Copyright. Please refer to the COPYRIGHT file
# distributed with this source distribution.
#
# This file is part of REDHAWK.
#
# REDHAWK is free software: you can redistribute it and/or modify it
# under the terms of the GNU Lesser General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# REDHAWK is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
# for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/.
#
if [ "$1" = "rpm" ]; then
    # A very simplistic RPM build scenario
    if [ -e FileWriter.spec ]; then
        mydir=`dirname $0`
        tmpdir=`mktemp -d`
        echo "1"
	cp -r ${mydir} ${tmpdir}/FileWriter-3.0.0dev0
        echo "2"
	tar czf ${tmpdir}/FileWriter-3.0.0dev0.tar.gz --exclude=".svn" -C ${tmpdir} FileWriter-3.0.0dev0
        echo "3"
	rpmbuild -ta ${tmpdir}/FileWriter-3.0.0dev0.tar.gz
        echo "4"
	rm -rf $tmpdir
    else
        echo "Missing RPM spec file in" `pwd`
        exit 1
    fi
else
    for impl in cpp ; do
        cd $impl
        if [ -e build.sh ]; then
            ./build.sh $*
        elif [ -e reconf ]; then
            ./reconf && ./configure && make $*
        else
            echo "No build.sh found for $impl"
        fi
        cd -
    done
fi