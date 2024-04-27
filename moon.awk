#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# moon phase
# need awk for floating point calculations
# awkward executing external commands & retieving results
#
# 2024-03-01 total rewrite
# 2024-03-08 tweaked external command -> function
#===============================================================================
BEGIN {
   adj=1185/24/60/60             # seconds adjust
   rot=29.530587962962+adj       # moon rotation days
   sec=rot*24*60*60              #               seconds
   pha=rot*3*60*60               #      phase    seconds
   col=13                        # column width

   printf("%"col+2"s","")
   for(j=0;j<8;j++)
   {
      switch(j)
      {
         case 0:;printf("%-"col+2"s","🌕");break
         case 1:;printf("%-"col+5"s","️🌖");break
         case 2:;printf("%-"col+5"s","️🌗");break
         case 3:;printf("%-"col+5"s","️🌘");break
         case 4:;printf("%-"col+5"s","️🌑");break
         case 5:;printf("%-"col+5"s","️🌒");break
         case 6:;printf("%-"col+2"s","🌓");break
         case 7:;printf("%s","🌔");break
      }
   }
   printf("\n")
 }
#===============================================================================
{
   for(i=0;i<14;i++)                      # some years need 14 lines
   {
      for(j=0;j<8;j++)                    # phase columns
      {
         q=sprintf("%d",$1+i*sec+j*pha)
         if(j==0)
         {
            fx_cmd("date -d @"q" +\"%T\"")
            printf("%-"col-3"s ",dte)
         }
         fx_cmd("date -d @"q" +\"%F\"")
         if(j==7)
            printf("%s",dte)
         else
            printf("%-"col"s",dte)
      }
      printf("\n")
   }
}
#===============================================================================
END {
}
#===============================================================================
# functions
#-------------------------------------------------------------------------------
# execute external command & get results
function fx_cmd(cmd)
{
   cmd | getline dte
   close(cmd)
}
#===============================================================================
