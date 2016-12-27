#!/bin/sh

DIRTOPROCESS=$1

if [ ! -d "$DIRTOPROCESS" ]
then
	echo directory not specified
	exit
fi

BASENAME=$(basename $DIRTOPROCESS)
SQDIR="/home/moz/squashfs/"
MNTDIR="/mnt/sqfs/moz/"
SQFILENAME="$BASENAME.squashfs"
MD5SUMFILE="md5sums.txt"
CURDIR=$(pwd)

echo Taking data from $DIRTOPROCESS
echo - mount dir is $MNTDIR
echo - squashfs dir is $SQDIR
echo - current dir is $CURDIR
echo and saving to $SQDIR$SQFILENAME

# check if squashfs file already exists
if [ -e "$SQDIR$SQFILENAME" ]
then
	echo output file already exits. aborting
	exit
fi

# md5 sum source
cd "$DIRTOPROCESS"
if [ -e "$MD5SUMFILE" ]
then
        echo md5 sum file already exists. Will not regenerate
else
        echo generating md5sums on source dir

        # generate and check return val.
        md5deep -lre . > /tmp/$MD5SUMFILE
        if [ $? -ne  0 ]
        then
                echo Error while calculating md5s
                exit
        fi

	cd $CURDIR
        mv "/tmp/$MD5SUMFILE" "$DIRTOPROCESS/$MD5SUMFILE"
fi

# generate squashfs image
echo creating squashfs file

cd $CURDIR
mksquashfs "$DIRTOPROCESS" "$SQDIR$SQFILENAME" -noappend
if [ $? -ne 0 ]
then
        echo Error while creating squashfs file
        exit
fi

# check the md5 values of the mounted image
echo checking files in squashfs
cd "$MNTDIR"
cd "$BASENAME"
if [ $? -ne 0 ]
then
        echo failed to access autofs mount at $MNTDIR$/$BASENAME
	exit
fi

md5sum -c $MD5SUMFILE --quiet
if [ $? -ne 0 ]
then
        echo failed to validate md5 sums
	exit
fi


# generate md5sum of squashfs file
echo generating md5 hash for new squashfs file

md5sum "$SQDIR$SQFILENAME" > "$SQDIR$SQFILENAME.md5"
if [ $? -ne 0 ]
then
        echo Error while calculating md5s
	exit
fi

# delete base data
echo delete original data using
echo rm -R "$DIRTOPROCESS"
