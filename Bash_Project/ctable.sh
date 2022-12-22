#!/usr/bin/bash

dbname=$(zenity --entry --title="Please, Enter Database Name" --text="Database Name")
flag=0

if [ -d ./dp/${dbname} ]
then
	zenity --info --title="" --text="Database exists" --no-wrap
        while [[ $flag -ne 1 ]]
        do
		tableName=$(zenity --entry --title="Please, Enter Table Name" --text="Table Name")
	
		if [[ -f ./dp/$dbname/$tableName ]]
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

	colNumber=$(zenity --entry --title="Please, Enter Number of columns" --text="Columns Number:")
	counter=1
	sep=":"
	rSep="\n"
	metaData="column"$sep"dataType"
	
	flag=0

	while [ $counter -le $colNumber ]
	do
		while [[ $flag -ne 1 ]]
        	do
                	#tableName=$(zenity --entry --title="Please, Enter Table Name" --text="Table Name")
                	colName=$(zenity --entry --title="Please Enter Column's name" --text="Coulumn ${counter} Name:")
			if [[ -f ./dp/$dbname/$colName ]]
                	then
                        	zenity --error --title="This column already exists" --no-wrap
                        	exit

                	elif [[ ${colName} == *['!'@#\$%^\&*()_+]* ]]
               	 	then
                        	zenity --error --title="Error" --text="Invalid name contains special characters" --no-wrap

	                elif [[ $colName = [1-9]* ]]
        	        then
                	        zenity --error --title="Error" --text="Invvalid name starts with numbers" --no-wrap

	                elif [[ $colName = *" "* ]]
        	        then
                	        zenity --error --title="Error" --text="Invalid name starts with space" --no-wrap
	                else
        	                flag=1
                	fi
	        done
		#colName=$(zenity --entry --title="Please Enter Column's name" --text="Coulumn ${counter} Name:")
     		
		flag=0
		PS3=">:"
	
		select var in "int" "string"
		do
			case $var in
				int) colType="int";
					break;;
	        		string) colType="string";
        	    			break;;
        			*) echo "Invalid" ;;
	      		esac
   		 done
		 if ! [ `cut -d: -f3 ./dp/${dbname}/${tableName}MetaData | grep -c -w "primary"` -gt 0 ]
		 then
			 select pk in "yes"
			 do
			 	case $pk in
					 yes) pk="primary";
						 break;;
					 "") pk="";
						 break;;
			 		 *) echo "Invalid" ;;
      				esac
			done
		 fi
	 
		 metaData+=$rSep$colName$sep$colType$sep$pk
		 ((counter++))
	 done
	 
	 touch ./dp/${dbname}/${tableName};
	 touch ./dp/${dbname}/${tableName}MetaData
	 echo -e $metaData >> ./dp/${dbname}/${tableName}MetaData
 	 echo $MetaData

	 if [[ $? == 0 ]]
	 then
		 zenity --info --title="" --text="Table (${tableName}) has created successfully" --no-wrap
		 #clear;
	 	 #echo "Table ($tableName) created successfully!"; 
		 #         ./dp/$dbname/$tableName
	 else
		 zenity --error --text="Error happened while creating table (${tableName})"
		 #echo "Error Creating Table $tableName"
		 #                 ./dp/$dbname/$tableName
	 fi
else
	zenity --error --text="Database does not exist" --no-wrap
	#echo "Database does not exist"
fi
