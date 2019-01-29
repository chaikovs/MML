#/bin/bash
# Script pour comparer fichier entre MML SOLEIL et version GREG

FIC_SOLEIL=`find ./applications -name $1.m`
FIC_GREG=`find /home/operateur/laurent/nv/applications -name $1.m`
echo "tkdiffb $FIC_GREG $FIC_SOLEIL"
tkdiffb $FIC_SOLEIL $FIC_GREG &
cp -i $FIC_GREG $FIC_SOLEIL
