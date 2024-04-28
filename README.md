# calendar

Calendar Utilities

cal.sh
--------------------------------------------------------------------------------
display multi-month calendar -4 curr +4                     #
--h does not work with cal, need to remove chars             #
cal.sed removes junk chars, hilite causes issue w/title.awk #

calen.awk
--------------------------------------------------------------------------------
given current date hilite calen stuff & other cal +3
mcal.sh 1 | calen.awk -v d="$(date +"%-d")"

2022-11-01 updated for hilite glitch, added spaces around match variables
2023-08-01 added border usage
2023-08-03 added auto border detect, just found out if() can do regex


calen.sh
--------------------------------------------------------------------------------
calendar stuff - 6 month calendar, events, & food pantry

2022-10-24 updated for 'calendar' error
2022-11-01 used head to limit julian display
2023-02-20 reworked calendar display & duplication issue

even though 'cal' turns off hilite for non-tty some code is still there
have to filter out funky codes with 'cal.sed'
otherwise awk output gets wonky

there is a glitch in 'calendar'
--B includes the day after today as well
so the date must be forced 2 days prior

clear

dow-n.sh
--------------------------------------------------------------------------------
n-th dow -> date


dow.sh
--------------------------------------------------------------------------------
dow letter(s) from date, no n
'date' offers no single letter day of week

letters derived from Spokane Falls Community College
N was my choice since there were no Sunday classes

2024-03-30 added more day of week options: single, triple, & full

food.sh
--------------------------------------------------------------------------------
Food Pantry & Gleaners (now the correct dates)

uses: julian-food.dat

gleaners was removed from data

food2.sh
--------------------------------------------------------------------------------
Food Pantry & Gleaners (now the correct dates)

calculates dates

defunct since gleaners is CRAP! ...?

2023-11-04 rewrote the date scan range

full-moon.sh
--------------------------------------------------------------------------------
moon phase table
given date show moon phases

jd.awk
--------------------------------------------------------------------------------
julian dates

jd.sh
--------------------------------------------------------------------------------
various julian dates

julian.sh
--------------------------------------------------------------------------------
various julian dates
keep track of julian epochs, birthdays, WTSHTF, TEOTWAWKI, or whatever

data file
yyy-mm-dd,optional offest,julian system / event
offset overrides date, if date it is informational only
blank lines print, comment lines skipped

can calc astro date using offset but not input (-)date

(-) offsets were causing issue, need tz adjust 5h/18000s

modified to read from data file, no more long case/esac
much easier to add & remove data from a file

added separate categories combined into one file
only rebuilds when a file is modified
julian-future.dat  julian-happy.dat  julian-shit.dat  julian-systems.dat
    -> julian.dat

emoji output in the terminal is squirrely
like reading a data file that has 'r' in it

2023-02-12 BUG FOUND time error with -f option & date input
2023-02-16 changed new file detect
2024-02-05 added deaths
2024-02-25 added text eidt julian-*.dat

mcal.awk
--------------------------------------------------------------------------------
reformat calendar

optional boarder b=1

mcal.sh
--------------------------------------------------------------------------------
mcal.sh [n]
    n  any integer
       none - no border
       1... - borders
cal -3 -> M start of week

2023-07-27 fixed awk prgm glitch, basically rewrote it
           made calendar a bit wider & centered
           added borders
           awk prgm can be used stand alone for calendar stuff
2023-08-01 fix octal glitch
2023-08-02 more octal fix, discovered formatting options: - _ 0 ^ #

moon.awk
--------------------------------------------------------------------------------
moon phase
need awk for floating point calculations
awkward executing external commands & retieving results

2024-03-01 total rewrite
2024-03-08 tweaked external command -> function

shows.awk
--------------------------------------------------------------------------------
formatted calendar & show dates
~/temp/temp.txt shows
~/temp/temp.dat calendar

shows.sh
--------------------------------------------------------------------------------
shows.dat display with optional calendar
shows.sed removes hiliting & escape colors
~/temp/temp.txt                shows
~/temp/temp.dat                calendar
~/Documents/Shows/_Shows.txt   combined files

2023-05-09 worked on last month display, tweaked read
2024-02-13 added days to go until event, tweaked things
2024-03-04 added expired & today indicators

tz.sh
--------------------------------------------------------------------------------
time zone display
