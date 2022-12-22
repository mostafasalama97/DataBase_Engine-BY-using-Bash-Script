#!/usr/bin/bash

./listdb.sh

dbname=$(zenity --entry --title="Enter Database Name" --text="DB Name:")

if [ -d "./dp/$dbname" ]
then
	cd ./dp/${dbname}
	pwd	

elif [[ ${dbname} == *['!'@#\$%^\&*()_+]* ]]
then
        zenity --error --title="Error" --text="Invalid name starts with special characters" --no-wrap

elif [[ ${dbname} = [1-9]* ]]
then
        zenity --error --title="Error" --text="Invalid name starts with number" --no-wrap

elif [[ ${dbname} = *" "* ]]
then
        zenity --error --title="Error" --text="Invalid name starts with space" --no-wrap

else
        zenity --error --title="Error" --text="Not Found Database" --no-wrap
fi
