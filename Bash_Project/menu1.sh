#!/usr/bin/bash

choice=$(zenity --entry --title="Selection Menu" --text="`echo "Choose from the List 1 to 5\n"` `echo "1- Create Database\n"` `echo "2- Show Database\n"` `echo "3- Drop Database\n"` `echo "4- Use Database\n"` `echo "5- Exit"`")

case $choice in
	1) ./createdp.sh
		;;
	2) ./listdb.sh
		;;
	3) ./removedb.sh
		;;
	4) ./connectdp.sh
		;;
	5) exit
		;;
esac
