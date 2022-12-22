#!/usr/bin/bash
#ls -F | grep /

zenity --info --title="Databases List" --text="`ls -F ./dp | grep /`"
