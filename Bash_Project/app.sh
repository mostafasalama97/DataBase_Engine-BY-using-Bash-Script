#!/usr/bin/bash

#Main Menu
typeset -i i
i=0
while [ $i -ne 4 ]
do
	source ./menu1.sh
	export choice
	i=${choice}
done

export dbname
#New Screen
if [ ! -d dp/${dbname} ]
then
	zenity --error --title="Error" --text="Not found database" --no-wrap

elif [ -d dp/${dbname} ]
then
	while [ $i -ne 8 ]
	do
		source ./tablesMenu.sh
		export choice
		i=${choice}
	done
fi
