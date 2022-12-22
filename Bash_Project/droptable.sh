#!/usr/bin/bash
#clear;
#echo "Enter database Name:"
#read -p "databsae name: " dbname

dbname=$(zenity --entry --title="Please, Enter Database Name" --text="Database Name:")

if [ -d ./dp/${dbname} ]
then
	#echo "database already exist"
	#echo "table in ${dbname} database"
	zenity --info --text="Database ${dbname} exists\n""`echo "Tables List:\n"`""`ls -1 ./dp/${dbname}`" --no-wrap
	#echo "Enter Table Name:"
	#read -p "table name: " tname
	
	tname=$(zenity --entry --title="Please, Enter Table Name" --text="Table Name:")
  	
	rm ./dp/${dbname}/${tname}MetaData
  	rm ./dp/${dbname}/${tname}
  
	if [[ $? == 0 ]]
	then
		zenity --info --text="Table ${tname} has been deleted succesfully" --no-wrap
		#echo "Table Dropped Successfully"
	else
                zenity --info --text="Error happened while deleting table ${tname}" --no-wrap
		#echo "Error Dropping Table $tName"
	fi

else
	zenity --error --text="Database doesn't exist" --no-wrap
	#echo "databse not exist"
fi
