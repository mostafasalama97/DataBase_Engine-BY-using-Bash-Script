#echo "enter your DB name :"
#read -p "database name = " dpname

dpname=$(zenity --entry --title="create database")

if [[ ${dpname} == *['!'@#\$%^\&*()_+]* ]]
then
 # echo "it is invalid name becouse it contain special character"
 	zenity --error --title="Error" --text="Invalid name contains special characters" --no-wrap
elif [[ $dpname = [1-9]* ]]
then
#	echo "invalid name start by number"
	zenity --error --title="Error" --text="Invvalid name starts with numbers" --no-wrap
elif [[ $dpname = *" "* ]]
then
#	echo "invalid name becouse space but do not worry we will change space by _ :) ya bro"
	zenity --error --title="Error" --text="Invalid name starts with space" --no-wrap
else
	mkdir ./dp/$dpname
fi
