#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

cd $HOME

#Set the background image
feh --bg-fill Life_by_Paco_Espinoza.jpg

xmodmap .xmodmaprc

#Load wmfs
exec /usr/local/bin/wmfs
