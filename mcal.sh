#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# mcal.sh [n]
#     n  any integer
#        none - no border
#        1... - borders
# cal -3 -> M start of week
#
# 2023-07-27 fixed awk prgm glitch, basically rewrote it
#            made calendar a bit wider & centered
#            added borders
#            awk prgm can be used stand alone for calendar stuff
# 2023-08-01 fix octal glitch
# 2023-08-02 more octal fix, discovered formatting options: - _ 0 ^ #
#-------------------------------------------------------------------------------
y=$(date +"%Y")                           # current year & month

m=$(date +"%-m")                          # - fix octal glitch
if (($#>0))                               # any command line triggers borders
then
   q=$1                                   # borders
else
   q=$1
fi

for((i=-1;i<2;i++))                       # month either side of current
do
   a=$y
   b=$((m+i))
   if((b==0))                             # wrap back year
   then
      ((a-=1))
      b=12
   fi
   if((b==13))                            # wrap up year
   then
      ((a+=1))
      b=1
   fi
   cal -d "$a-$b" | cal.sed | mcal.awk -v b=$q # generate calendar M start
done > ~/temp/temp.dat

c=0                                       # read calendar data into array
while IFS="" read lin
do
   a[c]=$(printf "%-21s\n" "$lin")
   ((c++))
done < ~/temp/temp.dat

if ((q))
then
   n=10
else
   n=8
fi
for((i=0;i<n;i++))                        # format calendars 3 wide
do
   j=$((i+n))
   k=$((j+n))
   printf " %s   %s   %s\n" "${a[i]}" "${a[j]}" "${a[k]}"
done
