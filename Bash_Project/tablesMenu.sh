#!/usr/bin/bash

choice=$(zenity --entry --title="Selection Menu" --text="`echo "Choose from the List 1 to 8\n"` `echo "1) Create Table\n"` `echo "2) List Tables\n"` `echo "3) Drop Table\n"` `echo "4) Insert into Table\n"` `echo "5) Select from Table\n"` `echo "6) Delete from Table\n"` `echo "7) Update Table\n"` `echo "8) Exit"`")

case $choice in
	1) ./ctable.sh
		;;
	2) ./showtable.sh
		;;
	3) ./droptable.sh
		;;
	4) ./insintable.sh
		;;
	5) ./select.sh
		;;
	6) ./delfromtable.sh
		;;
	7) ./update.sh
		;;
	8) exit
		;;
esac
