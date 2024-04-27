#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# Food Pantry & Gleaners (now the correct dates)
#
# calculates dates
#
# defunct since gleaners is CRAP! ...?
#
# 2023-11-04 rewrote the date scan range
#-------------------------------------------------------------------------------
source ~/data/global.dat
q=$((24*60*60))                                          # seconds in day
o="$HOME/Documents/food2.txt"                            # output file
s1="Food Pantry (anybody, HSI) 9:00"                     # text
s2="Gleaners (55+, First Christ Church) 10:00"
s3="${RED}WARNING! Food Has Gotten CRAPPY!${nrm}"
h1=${s1% (*}                                             # headings
h2=${s2% (*}
h1=${h1^^}
h2=${h2^^}
l1=${#h1}                                                # length
l2=${#h2}
w1=20                                                    # center gap
w2=$((w1/2))                                             # Food Pantry gap
w3=$((w1+l1+l2+w2-10))
y0=$(printf "%d" $(date +%Y))
m0=$(printf "%d" $(date +%m))
#-------------------------------------------------------------------------------
title-80.sh -t line "$s1 & $s2\n$s3" | tee "$o"
printf "%s%${w3}s%s\n" "$h1" "| " "$h2" | tee -a "$o"
printf "%-10s%${w2}s%-10s%${w1}s%s\n" "PICKUP" "" "UNLOAD" "| " "PICKUP" | tee -a "$o"
#-------------------------------------------------------------------------------
for ((i=-1;i<3;i++))
do
   m=$((m0+i))          # month + offset

   c=$((m-1))           # year offset
   if ((c<0))           # negative adjust
   then
      c=$((c-11))
   fi
   c=$((c/12))          # year offset
   y=$((y0+c))          # year + offset

   m=$(((m-1)%12+1))    # month wrap
   if ((m<1))
   then
      m=$((m+12))
   fi

   u=$(dow-n.sh $y $m T 2)                            # Food Pantry Unload
   n=$(($(date -d $u +%s)-5*q))                       # pickup 5 day before
   f1=$(date -d @$n +%F)                              # adjusted date
   f2=$(dow-n.sh $y $m M 4)                           # Gleaners

   if ((i<0))
   then
      printf "$Wht"
   elif ((i==0 || i==1))
   then
      printf "$MAG"
   fi
   printf "%s%${w2}s%s%${w1}s%s\n" "$f1" "" "$u" "| " "$f2"
   printf "$nrm"
done

echo -e "dates subject to change" | tee -a "$o"
#-------------------------------------------------------------------------------
