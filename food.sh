#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# Food Pantry & Gleaners (now the correct dates)
#
# uses: julian-food.dat
#
# gleaners was removed from data
#-------------------------------------------------------------------------------
w1=13                                        # column widths
w2=25                                        # Food Pantry=11, max=27
w3=$((80-2*(w1+w2)))

inp="$HOME/data/julian-food.dat"             # files
txt="$HOME/Documents/food.txt"

s1="Food Pantry"                             # search strings

title-80.sh -t line "$s1 9:00" | tee "$txt"

cat $inp |
{
   c=0
   while IFS="|" read -a ary
   do
      if ((c%2))                             # column display
      then
         printf "%-${w1}s%-${w2}s\n" "${ary[0]}" "${ary[2]}"
      else
         printf "%-${w1}s%-${w2}s%${w3}s" "${ary[0]}" "${ary[2]}" ""
      fi
      ((c++))
   done
   if ((c%2))                                # incomplete column
   then
      printf "\n"
   fi
} | tee -a "$txt"
#-------------------------------------------------------------------------------
