#!/bin/sh

SRCDIR="$1"
DSTDIR="$2"
CURDIR=$(pwd)

MD5SUMFILE="md5sums.txt"

echo copy stuff from $SRCDIR to $DSTDIR
echo current dir is $CURDIR

# check for SRCDIR existence
if [ ! -d "$SRCDIR" ]
then
	echo Source dir does not exist or is not a directory
	exit
fi

# check for DSTDIR existence or create
if [ -d "$DSTDIR" ]
then
	echo Destination dir exists already. exiting.
	exit
fi

# md5 sum source
cd "$SRCDIR"
if [ -e "$MD5SUMFILE" ]
then
	echo md5 sum file already exists. Will not regenerate
else
	echo generating md5sums on source dir $SRCDIR

	# generate and check return val.
	md5deep -lre . > /tmp/$MD5SUMFILE
	if [ $? -ne 0 ]
	then
		echo Error while calculating md5s
		exit
	fi
	mv /tmp/$MD5SUMFILE .
fi

# copy stuff (with -p)
echo copying files
cd "$CURDIR"
cp -pR "$SRCDIR" "$DSTDIR"

# verify copy
echo verifying
cd "$DSTDIR"
md5sum -c $MD5SUMFILE --quiet

if [ $? -ne 0 ]
then
	echo MD5 sum check error
	exit
fi

# delete
echo to clean up
echo rm -r "$SRCDIR"

