#!/bin/bash

# find file with this pattern
DPATH=`find $MLROOT/.. -name "*.m" -exec grep -l '/home/matlabML' {} \;`

# subtitution for all files
for f in $DPATH
do
  echo $f
  sed -i 's/matlabML/production\/matlab\/matlabML/g' $f
done

