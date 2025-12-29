#!/bin/bash

keyboard=$(lsusb | grep -i "aula")

if [ ! -z "$keyboard" ]; then
    echo "  "
fi
