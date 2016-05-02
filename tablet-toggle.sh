#!/bin/bash

# When activated via shortcut (or event -- try thinkpad rotation)
# Rotate the screen and enable/disable the onboard keyboard program
# Also disable/enable the touchpad

# Touchpad id# from xinput -list
touchpadID=12
tf=${HOME}/.tablet_mode

#if "$1" #"$(head -n 1 "$tf")";
if "$(head -n 1 "$tf")"
then
    killall onboard
    xinput set-prop "$touchpadID" "Device Enabled" 1
    xrandr --output LVDS1 --rotate normal
    xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axes Swap" 0
    xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axis Inversion" 0 0
    xinput set-prop --type=int --format=8 4 "Evdev Axis Inversion" 0 0
    echo "false">"$tf"
else
    onboard &
    xinput set-prop "$touchpadID" "Device Enabled" 0
    xrandr --output LVDS1 --rotate right
    xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axes Swap" 1
    xinput set-prop --type=int --format=8 "Atmel Atmel maXTouch Digitizer" "Evdev Axis Inversion" 0 1
    xinput set-prop --type=int --format=8 4 "Evdev Axis Inversion" 0 1
    echo "true">"$tf"
fi

