#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# given current date hilite calen stuff & other cal +3
# mcal.sh 1 | calen.awk -v d="$(date +"%-d")"
#
# 2022-11-01 updated for hilite glitch, added spaces around match variables
# 2023-08-01 added border usage
# 2023-08-03 added auto border detect, just found out if() can do regex
#
#===============================================================================
BEGIN {
   Wht="\033[0;37m"
   rev="\033[0;30;42m"                          # normal
   # rev="\033[0;7m"                             # little brighter
   non="\033[0m"
}
#===============================================================================
{
   if(NR==1)                                    # border detect
      if($0 ~ /^ \+/)
         q=1
   switch($0)
   {
         case /[A-Za-z]+ [0-9]{4}/ :            # >>> hilite select records
         case /PICKUP/ :
            dte=$1" "$2
            printf(Wht"%s\n"non,$0)
            break
         default :
            switch(t)                           # >>> non-select record handling
            {
               case 0 :                         # >>> cal mode
                  if(NR>2 && NR<9)              # first month row
                  {                             # pull apart month cols
                     if(q)                      # w/border
                     {
                        a=substr($0,1,29)
                        b=substr($0,30,21)      # second month column
                        c=substr($0,51)
                     }
                     else                       # no border
                     {
                        a=substr($0,1,24)
                        b=substr($0,25,21)      # second month column
                        c=substr($0,46)
                     }
                     if(match(" "b" "," "d" ")) # search second month col for day
                        sub(d,rev d non,b)      # hilite day
                     printf("%s%s%s\n",a,b,c)   # combine month cols
                  }
                  else
                     print
                  break
               case 1 :                         # >>> calendar mode
                  sub(/.\t/," ")                # remove * & \t
                  print
                  break
               case 2 :                         # >>> other
                  print
            }
   }
}
#===============================================================================
END {
}
#===============================================================================
# functions
#-------------------------------------------------------------------------------
#===============================================================================
