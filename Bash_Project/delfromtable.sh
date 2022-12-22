#!/usr/bin/bash

dbname=$(zenity --entry --title="Please, Enter Database Name" --text="Database Name:")
flag=0

if [ -d ./dp/${dbname} ]
then	
	while [[ $flag -ne 1 ]]
	do
		tableName=$(zenity --entry --title="Please, Enter Table Name" --text="Table Name:")
	
		if [[ -f ./dp/${dbname}/${tableName}MetaData ]];
		then
			row=$(zenity --entry --title="" --text="Enter Row's Number to delete:")
			sed -i "$row d" ./dp/${dbname}/${tableName}

                elif [[ -f ./dp/$dbname/$tableName ]]
                then
                        zenity --error --title="This table already exists" --no-wrap
                        exit

                elif [[ ${tableName} == *['!'@#\$%^\&*()_+]* ]]
                then
                        zenity --error --title="Error" --text="Invalid name contains special characters" --no-wrap

                elif [[ $tableName = [1-9]* ]]
                then
                        zenity --error --title="Error" --text="Invvalid name starts with numbers" --no-wrap

                elif [[ $tableName = *" "* ]]
                then
                        zenity --error --title="Error" --text="Invalid name starts with space" --no-wrap
                else
                        flag=1
                fi
        done

	#elif [ "$tableName" = "" ];      
	#then
	#	zenity --error --text="Invalid Name"
	#	#echo "Invalid table name ";
	#fi
else
	zenity --error --text="Database doesn't exist" --no-wrap
	#echo "database not exist"
fi 
