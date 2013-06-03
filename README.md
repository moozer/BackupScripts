BackupScripts
=============

Some scripts to help me do backup using md5 sums and squashfs

Scripts and usage

## CopyWithMd5.sh ##
Usage
  CopyWithMd5.sh [from] [to]
  
1. Uses md5deep to generate md5sums.txt with all md5sum from all subdirs
  If the file exists allready, it will not be regenerated
1. Copies all files from [from] to [to]
1. Uses md5sum to verify all files in new location
1. It does NOT delete source files, but gives an easy copy'n'paste text should you want to :-)


## CreateSqfsImg.sh ##
Usage
  CreateSqfsImg.sh [dir]
    
1. Uses md5deep to generate md5sums.txt with all md5sum from all subdirs
  If the file exists allready, it will not be regenerated
1. Creates a squashfs file with the content of [dir] in the automount location.
  The automount location is specified in the script, and requires automount to configured as mine is :-)
1. The newly created image is checked using the md5sums.txt file in the root of the image. 
1. It does NOT delete source files, but gives an easy copy'n'paste text should you want to :-)

## CreateSqfsImg.sh ##
Usage
  MakeList.sh

1. Creates ~/bin
1. Make the symlinks of the scripts to ~/bin
  Consider adding ~/bin to the PATH variable

