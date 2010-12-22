#!/bin/sh


calc()
{
     echo "`echo $1 | bc -l | cut -d. -f1`"
}

#progressbar x y w h bordcolor bgcolor barcolor value maxvalue
progressbar()
{
    local BARH=`calc "$8/$9*$3"`
    local BORD=" \b[`calc \"$1 - 1\"`;`calc \"$2 - 1\"`;`calc \"$3 + 2\"`;`calc \"$4 + 2\"`;$5]\ "
    local BGBAR=" \b[$1;$2;$3;$4;$6]\ "
    local VBAR=" \b[$1;$2;$BARH;$4;$7]\ "

    echo "$BORD$BGBAR$VBAR"
}

# DATE
DATE=`date +"%H:%M %d/%m/%y"`
HEURE="$SC |$NC $DATE"

#Name 
USER=`whoami`
NAME=`uname -n`
ME="$TC$USER$SC@$NC$NAME$SHL$SC |"

ECRAN0="$ME$HEURE"
ECRAN1="$ME$HEURE"

/usr/local/bin/wmfs -s 0 "$ECRAN0"
/usr/local/bin/wmfs -s 1 "$ECRAN1"
