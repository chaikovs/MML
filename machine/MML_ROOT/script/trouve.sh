#/bin/sh
# look for file in the directory without going to archived files

find ./ -path './.snapshot' -prune -o -name $1
