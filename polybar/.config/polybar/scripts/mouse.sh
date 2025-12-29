#!/bin/bash

mouse=$(lsusb | grep -i "mouse")

if [ ! -z "$mouse" ]; then
    echo " 󰍽 "
fi

