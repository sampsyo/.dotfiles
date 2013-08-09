#!/bin/sh
disp=VGA1
idisp=LVDS1

onmode=`xrandr | grep $disp | grep \+`
if [ "$onmode" = "" ]; then
    xrandr --output $disp --auto --same-as $idisp
else
    xrandr --output $disp --off
fi

echo "sup" >> ~/what.txt
