#!/bin/sh
# Script for setting the rights after use of CVS
# Some file have only read only access
USERNAME=`whoami`
ROOTNAME=$MLROOT/../
echo Directory name is $ROOTNAME

if [ "$USERNAME" != "operateur" ]; then
echo "specific to Hyperion"
# Test for HYPERION
# Force rights

chown -R .mml $ROOTNAME
chmod -R a+rX $ROOTNAME
find $ROOTNAME -type d -exec chmod o+r {} \;
find $ROOTNAME -type f -exec chmod g+rw {} \;
find $ROOTNAME -type d -exec chmod g+rw {} \;
else
echo "specific to controlroom"
find $ROOTNAME -type f -exec chmod u+rw {} \;
find $ROOTNAME -type d -exec chmod u+rw {} \;
fi

# HYPERION and CTRLROOM
# set writable file for OpsData
if [ "$USERNAME" != "operateur" ]; then
echo "OPSdata specific to Hyperion"
chmod -R u+w $ROOTNAME/machine/SOLEIL/StorageRingOpsData
chmod -R u+w $ROOTNAME/machine/SOLEIL/LT1OpsData
chmod -R u+w $ROOTNAME/machine/SOLEIL/LT2OpsData
chmod -R u+w $ROOTNAME/machine/SOLEIL/BoosterOpsData
else
echo "OPSdata specific to controlroom"
chmod -R u+w $MLCONFIGROOT/machine/SOLEIL/StorageRingOpsData
chmod -R u+w $MLCONFIGROOT/machine/SOLEIL/LT1OpsData
chmod -R u+w $MLCONFIGROOT/machine/SOLEIL/LT2OpsData
chmod -R u+w $MLCONFIGROOT/machine/SOLEIL/BoosterOpsData
fi
# Test
