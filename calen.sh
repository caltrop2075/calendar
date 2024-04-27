#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# calendar stuff - 6 month calendar, events, & food pantry
#
# 2022-10-24 updated for 'calendar' error
# 2022-11-01 used head to limit julian display
# 2023-02-20 reworked calendar display & duplication issue
#
# even though 'cal' turns off hilite for non-tty some code is still there
# have to filter out funky codes with 'cal.sed'
# otherwise awk output gets wonky
#
# there is a glitch in 'calendar'
#--B includes the day after today as well
# so the date must be forced 2 days prior
#
clear
#--------------------------------------------------------------------- variables
source ~/data/global.dat
# q=1                                                   # calendar border
pre=9                                                 # pre/aft event days
aft=30
m1=$(date +"%m")                                      # month num
if [[ $m1 =~ ^0 ]]                                    # remove month leading 0
then
   m1=${m1/0/}                                        # m1=${m1#0} also works
fi
d1=$(date +"%d")                                      # day
f=1                                                   # first line wrap flag
l=0                                                   # last month
unset LC_ALL                                          # display crap
#--------------------------------------------------------------------------- cal
title-80.sh -t line "Calendar & Events For The Next 30 Days & pre $pre"

# mcal.sh $q | calen.awk -v d="$(date +"%-e")" -v q=$q      # cal mode, M start
# if ((q==0))
# then
   # echo
# fi
mcalb.sh
sleep 1
#---------------------------------------------------------------------- calendar
# issue with & duplication of event
# calendar -w -B $pre, goes one day past, combined is ok
# calendar -w -A $aft
# since there is no full date with calendar
# special handling of dates are necessary
# add 12 to all following dates
#  12 -> 12
#   1    13
#   2    14
# WARNING! leading 0 octal

# echo $div_sl
calendar -w -B $pre -A $aft |
while read w m d s
do
   d=${d/\*/}
   case $m in                                         # Mmm -> mm
      "Jan")m2=1;;
      "Feb")m2=2;;
      "Mar")m2=3;;
      "Apr")m2=4;;
      "May")m2=5;;
      "Jun")m2=6;;
      "Jul")m2=7;;
      "Aug")m2=8;;
      "Sep")m2=9;;
      "Oct")m2=10;;
      "Nov")m2=11;;
      "Dec")m2=12;;
   esac
   if (( f == 1 )) && (( m1 < 13 )) && (( m1 < m2 ))  # adjust year month wrap
   then
      m1=$(( m1 + 12 ))
   fi
   f=0
   if (( m2 < l ))
   then
      m3=$(( m2 + 12 ))
   else
      m3=$m2
   fi
   l=$m3
   if (( "$m3$d" < "$m1$d1" ))                        # hilite old/new
   then
      echo -e "$grn$w $m $d $s$nrm"
   else
      echo "$w $m $d $s"
   fi
done
sleep 1
#------------------------------------------------------------------------- other
# food.sh                                               # new julian category
# printf "$RED%s$nrm\n" "☠️  NO MORE Gleaners! ☠️"
food2.sh
sleep 1
phone.sh
sleep 1
# echo $div_sl
pay.sh -n
#-------------------------------------------------------------------------------
