#!/bin/bash
#export LD_LIBRARY_PATH=/usr/Local/matlab/runtime/glnx86:/usr/Local/matlab/bin/glnx86:/usr/Local/matlab/sys/os/glnx86:/usr/Local/matlab/sys/java/jre/glnx86/jre1.5.0/lib/i386/native_threads:/usr/Local/matlab/sys/java/jre/glnx86/jre1.5.0/lib/i386/server:/usr/Local/matlab/sys/java/jre/glnx86/jre1.5.0/lib/i386/client:/usr/Local/matlab/sys/java/jre/glnx86/jre1.5.0/lib/i386:$LD_LIBRARY_PATH
#set path
. $MLROOT/../machine/SOLEIL/standalone_applications/set_path_standaloneMML.sh

APPLI=orbitcontrol
$MLROOT/../machine/SOLEIL/standalone_applications/$APPLI/$APPLI/$APPLI
