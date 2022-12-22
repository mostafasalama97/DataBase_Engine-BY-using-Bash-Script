#!/usr/bin/bash

#echo "enter database name"
#read dbname

dbname=$(zenity --entry --title="Please, Enter Database Name" --text="Database Nane:")

if [ -d ./dp/${dbname} ]
then
	cd ./dp/${dbname}/
	#echo "data base ${dbname} table is: "
	zenity --info --title="${dbname} Database Tables" --text="`ls -1`" --no-wrap
else
	zenity --error --text="Database name doesn't exist" --no-wrap
	#echo "data base not exist"
fi
