#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# n-th dow -> date
#
#-------------------------------------------------------------------------------
if (($#==4))
then
   w=$(date -d $1-$2-01 +%w)           # first of month dow
   case $3 in                          # alpha -> numeric
      N|n)i=0;;
      M|m)i=1;;
      T|t)i=2;;
      W|w)i=3;;
      R|r)i=4;;
      F|f)i=5;;
      S|s)i=6;;
   esac
   f=$(((i-w+7)%7+1))                  # first dow
   s=$(date -d  "$1-$2-$f" +"%s")      # epoch seconds
   q=$((s+7*($4-1)*24*60*60))          # add offset
   date -d @$q +%F                     # date
else
   echo "n-th dow -> date"
   echo "usage: dow.sh yyyy mm dow n"
   echo "  dow: N M T W R F S (can use lower case)"
   echo "    n: 1-? dow"
fi
#-------------------------------------------------------------------------------
