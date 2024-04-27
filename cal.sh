#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# display multi-month calendar -4 curr +4                     #
#--h does not work with cal, need to remove chars             #
# cal.sed removes junk chars, hilite causes issue w/title.awk #
#-------------------------------------------------------------------------------
n=1
cal -B $((3*n+1)) -A $((3*n+1)) | cal.sed | title.awk -v t="line"
#-------------------------------------------------------------------------------
