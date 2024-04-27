#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# dow letter(s) from date, no \n
# 'date' offers no single letter day of week
#
# letters derived from Spokane Falls Community College
# N was my choice since there were no Sunday classes
#
# 2024-03-30 added more day of week options: single, triple, & full
#---------------------------------------------------------------------- function
fx_dte ()                                          # date detect
{
   r="[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]"  # regex
   d="$a"                                          # get dflt date
   if [[ $b =~ $r ]]                               # get date if 2nd arg
   then
      d="$b"
   fi
}
#-------------------------------------------------------------------- initialize
a=$1;b=$2;c=$#                                     # because fx_dte uses $1...
w=(N M T W R F S)                                  # week day array
#------------------------------------------------------------------ main program
if [[ $* =~ -h ]]                                  # help
then
   echo
   echo "dow.sh [yyyy-mm-dd -0 -1 -2 -h]"
   echo "day of week from given date"
   echo "   -h help"
   echo "   -0 is optional"
   echo "   -0 N      M      T       W         R        F      S"
   echo "   -1 Sun    Mon    Tue     Wed       Thu      Fri    Sat"
   echo "   -2 Sunday Monday Tuesday Wednesday Thursday Friday Saturday"
elif (($#==1)) || [[ $1 == -0 ]] || [[ $2 == -0 ]] # single letter day of week
then
   fx_dte
   n=$(date -d "$d" +"%w")                         # week day index
   printf "%s" "${w[n]}"
elif [[ $1 == -1 ]] || [[ $2 == -1 ]]              # triple letter day of week
then
   fx_dte
   printf "%s" $(date -d "$d" +"%a")
elif [[ $1 == -2 ]] || [[ $2 == -2 ]]              # full day of week
then
   fx_dte
   printf "%s" $(date -d "$d" +"%A")
fi
#-------------------------------------------------------------------------------
