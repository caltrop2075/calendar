#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# shows.dat display with optional calendar
# shows.sed removes hiliting & escape colors
# ~/temp/temp.txt                shows
# ~/temp/temp.dat                calendar
# ~/Documents/Shows/_Shows.txt   combined files
#
# 2023-05-09 worked on last month display, tweaked read
# 2024-02-13 added days to go until event, tweaked things
# 2024-03-04 added expired & today indicators
#-------------------------------------------------------------------------------
if [[ $1 = "-h" || $1 = "--help" ]]                   # help
then
   echo
   echo "usage: shows.sh"
   echo "       shows.sh -n   no calendar"
else                                                  # initialization
   clear
   source ~/data/global.dat
   msg="$Wht$(date +"%F")$nrm Shows: auction, fleamarket, tractor
      ${grn}first & last days of shows everyone is (un)packing${nrm}
      ${grn}ALL shows are in decline, as is the entire world${nrm}
      ${grn}these are the End-Times -- Bible:Revelation${nrm}"
   title-80.sh -t line "$msg"
   title-80.sh -t line "$msg" | shows.sed > ~/Documents/Shows/_Shows.txt
   echo -n > ~/temp/temp.dat                          # reset files
   echo -n > ~/temp/temp.txt
   lst=0                                              # listing flag
   dt3=$(date +"%F")                                  # today date
   jd3=$(date -d "$dt3" +"%s")                        # today julian
#----------------------------------------------- generate calendar & event files
   cat ~/data/shows.dat |
   while read dt1 dt2 str
   do
      q=${dt1:0:1}
      if [[ $q != "" ]] && [[ $q != "#" ]]            # ignore blank & comment
      then
         dw1=$(date -d $dt1 +"%a")                    # get dw1
         jd1=$(date -d $dt1 +"%s")
         dm1=$(date -d $dt1 +"%m")

         dw2=$(date -d $dt2 +"%a")                    # get dw2
         jd2=$(date -d $dt2 +"%s")
         dm2=$(date -d $dt2 +"%m")

         jd0=$(( ($jd2-$jd1)/60/60/24+1 ))
         dlt=$(( (jd1-jd3)/60/60/24 ))                # delta days to go
         if ((dlt>0))
         then
            exp=""
         elif ((dlt==0))
         then
            exp="<<< today"
         else
            exp="< expired"
         fi

         printf "%s\n%s %s   %s %s   %02d_d   % 04d_t %s\n\n" "$str" "$dt1" "$dw1" "$dt2" "$dw2" "$jd0" "$dlt" "$exp" >> ~/temp/temp.txt
         if [[ $1 != "-n" && $dm1 != $lst ]]
         then
            cal -d $dt1 | shows.sed >> ~/temp/temp.dat
            lst=$dm1                                  # save last printed month
         fi
         if [[ $1 != "-n" && $dm1 != $dm2 ]]          # print overlap/last month
         then
            cal -d $dt2 | shows.sed >> ~/temp/temp.dat
            lst=$dm2                                  # save last printed month
         fi
      fi
   done
#----------------------------------------------------- combine calendar & events
   cat ~/temp/temp.dat | shows.awk -v f=~/temp/temp.txt | tee -a ~/Documents/Shows/_Shows.txt
fi
#-------------------------------------------------------------------------------
