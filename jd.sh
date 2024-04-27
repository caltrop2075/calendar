#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# various julian dates
#-------------------------------------------------------------------------------
# clear
# source ~/data/global.dat
unset LC_ALL                        # for number comma
tz=$(date +"%::z|%s")               # tz|epoch
dte=$(date -d @${tz#*|} +"%F %T")   # epoch -> date time
#-------------------------------------------------------------------------------
title-80.sh -t line "Various Julian Dates\n$dte"
while read ofs str
do
   printf "%s|%s|%s\n" "$tz" "$ofs" "$str" | jd.awk  # tz|epoch|offset|string
done << EOF
2440587.70835 Astronomical      -4713-11-24
 719528.00000 HP48 Ticks         0000-01-01
 141427.00000 HP48 Gregorian     1582-10-15
  40587.20835 Astro Mean JD      1858-11-16
  25569.00000 Libre Off 1        1899-12-30
  25567.00000 Libre Off 2/Excel  1900-01-01
  24107.00000 Libre Off 3        1904-01-01
      0.00000 Linux              1970-01-01
  -7887.00000 Internet           1991-08-06
EOF
#-------------------------------------------------------------------------------
