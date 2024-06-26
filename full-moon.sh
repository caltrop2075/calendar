#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# moon phase table
# given date show moon phases
#-------------------------------------------------------------------------------
# clear
source ~/data/global.dat
tgt=$(date +"%Y")
#-------------------------------------------------------------------------------
title-80.sh -t line "Full Moons & Phases $tgt"
while read yr dte tim
do
   if [[ $yr == $tgt ]]
   then
      # printf "%s\n" "$yr"
      echo $(date -d "$dte $tim" +%s) | moon.awk
      # printf "%s\n" "$div_s"
   fi
done << EOF
---- 2019-11-12 08:37:00
2020 2019-12-11 21:40:47
2021 2020-12-29 23:30:09
2022 2021-12-19 12:15:42
2023 2022-12-09 01:01:16
2024 2023-12-28 02:50:37
2025 2024-12-16 15:36:11
2026 2025-12-06 04:21:44
2027 2026-12-25 06:11:06
2028 2027-12-14 18:56:39
2029 2028-12-03 07:42:13
2030 2029-12-22 09:31:34
EOF
