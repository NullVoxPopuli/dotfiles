#!/bin/bash
#
# Set up the OBS environment
#
# xrandr to print current  dimensions / size
# DP-0 connected primary 3840x1600+0+0 (normal left inverted right x axis y axis) 880mm x 367mm
mmX=880
mmY=367
x=3840
y=1600

osStatusBar=30

# getX 1920 => 1920/440
function getX() {
  echo "$1/$(( mmX * $1 / x ))"
}

function getY() {
  echo "$1/$(( mmY * $1 / y ))"
}

function topRightCorner() {
  local desiredX=$1
  local desiredY=$2

  echo "$(getX $desiredX)x$(getY $desiredY)+$((x - desiredX))+$osStatusBar"
}

# 1080p, but in the top-right corner, excluding the top / status bar (30px)
# "w px" / "w mm" x "h px" / "h mm" + offsetX + offset Y
xrandr --setmonitor stream1 $(topRightCorner 1920 1080) none
xrandr --setmonitor obs-portrait $(topRightCorner 720 1280) none
