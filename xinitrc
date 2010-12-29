#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

#Set the background image
feh --bg-scale Life_by_Paco_Espinoza.jpg

xmodmap .xmodmaprc

#Load wmfs
exec /usr/local/bin/wmfs
