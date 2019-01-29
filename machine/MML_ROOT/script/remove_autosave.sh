#/bin/sh

#remove autosave created by Matlab
find ./ -path './.snapshot' -prune ! -path './.snapshot' -o -type f -name "*m~" -o -name "*.asv" 
#find ./ -path './.snapshot' -prune ! -path './.snapshot' -o -type f -name "*m~" -o -name "*.asv" | xargs \rm 
# Ne fonctionne pas : pourquoi ???
#find ./ -path './.snapshot' -prune -o -type f -name "*m~" -o -name "*.asv" -exec \rm {} \;

find ./ -type f -name "*m~" -o -name "*.asv" -o -path './.snapshot' -prune #

