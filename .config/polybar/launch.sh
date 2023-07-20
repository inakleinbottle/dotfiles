#!/usr/bin/env bash

# Take from the polybar wiki https://github.com/polybar/polybar/wiki

polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar-mainbar.log 
polybar mainbar 2>&1 | tee -a /tmp/polybar-mainbar.log & disown 

echo "Bars launched..."
