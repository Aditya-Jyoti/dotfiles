#!/bin/bash

webcam=$(lsusb | grep -i webcam)

if [ ! -z "$webcam" ]; then
    echo " 󰄀 "
fi
