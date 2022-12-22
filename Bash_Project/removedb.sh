#!/usr/bin/bash

./listdb.sh

dpname=$(zenity --entry --title="Enter Database Name" --text="Database u want to remove")

if [ -d ./dp/$dpname ]
then
	rm -r ./dp/${dpname}

elif [[ ${dpname} == *['!'@#\$%^"'"\&*()_+]* ]]
then
       	#echo "it is invalid name becouse it contain special character"
        zenity --error --title="Error" --text="Invalid name with special characters" --no-wrap

elif [[ ${dpname} = [0-9]* ]]
then
	#echo "invalid name start by number"
        zenity --error --title="Error" --text="Invalid name starts with Numbers" --no-wrap

elif [[ ${dpname} = *" "* ]]
then
	#echo "the name you are entered is file"
        zenity --error --title="Error" --text="Invalid name starts with Numbers" --no-wrap

elif [[ ${dpname} = "" ]]
then
        #echo "error: empety name "
	zenity --error --title="Error" --text="Empty Name" --no-wrap
else
	#echo "Not found"
        zenity --error --title="Error" --text="Not Found" --no-wrap
fi
