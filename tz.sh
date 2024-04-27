#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# time zone display
#-------------------------------------------------------------------------------
clear
source ~/data/global.dat
msg="Time Zones: United States, ${WHT}Local${nrm}, ${RED}Select${nrm} & ${grn}Other${nrm}"
msg="$msg\nzone reference see: lstz.sh -> ~/data/tz.dat"
#-------------------------------------------------------------------------------
title-80.sh -t line "$msg"
while read lin
do
   TZ="$lin"
   col="$grn"
   sta="$lin"
   case $lin in
      "US/Hawaii"       ) col="$nrm";;
      "US/Alaska"       ) col="$nrm";;
      "US/Pacific"      ) col="$nrm";;
      "US/Mountain"     ) col="$nrm";;
      "US/Central"      ) col="$RED";sta=">Texas<";;
      "US/Eastern"      ) col="$WHT";sta=">Indiana<";;
   esac
   printf "$col%s %5s %s %s$nrm\n" "$(date +"%F %R")" "$(date +"%Z")" "$(date +"%z")" "$sta"
done << EOF
Etc/GMT+12
US/Samoa
US/Hawaii
Pacific/Marquesas
US/Alaska
US/Pacific
US/Mountain
US/Central
US/Eastern
Canada/Atlantic
Canada/Newfoundland
America/Buenos_Aires
Brazil/East
Atlantic/Azores
Etc/GMT
Europe/Paris
Europe/Athens
Europe/Moscow
Asia/Dubai
Asia/Karachi
Asia/Calcutta
Etc/GMT-6
Asia/Bangkok
Asia/Singapore
Asia/Tokyo
Pacific/Guam
Pacific/Guadalcanal
Pacific/Wake
EOF
#-------------------------------------------------------------------------------
