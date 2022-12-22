#!/usr/bin/bash

#clear
#echo "enter database name"
#read dbname
#echo -n "Enter Table name : "
#read tableName

dbname=$(zenity --entry --title="Please, Enter Database Name" --text="Database Name:")
tableName=$(zenity --entry --title="Please, Enter Table Name" --text="Table Name:")

if [[ -f ./dp/${dbname}/${tableName} ]];
then
	clear
	awk -F# '{print $0}' ./dp/${dbname}/${tableName}

elif [ "$tableName" = "" ];
then
	zenity --error --text="Invalid Name"
	#echo "Invalid ";
fi
   
