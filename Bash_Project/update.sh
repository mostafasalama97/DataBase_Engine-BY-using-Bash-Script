#!/usr/bin/bash


echo "enter database nme"
read dbname
if [ -d ./dp/${dbname} ]
then
	echo "Table Name you want to update: "
	read tableName
	if ! [[ -f ./dp/${dbname}/${tableName} ]]
	then
		echo "Table $tableName isn't existed ,choose another Table"
		exit;
	fi

	colsNum=`awk 'END{print NR}' ./dp/${dbname}/${tableName}MetaData`
	sep=":"
	rSep="\n"
	colsNum=2

	for (( i = 2; i <= $colsNum; i++ ));
	do
		colName=$(awk 'BEGIN{FS=":"}{if(NR=='$i') print $1}' ./dp/${dbname}/${tableName}MetaData)
		colType=$(awk 'BEGIN{FS=":"}{if(NR=='$i') print $2}' ./dp/${dbname}/${tableName}MetaData)
		colKey=$(awk 'BEGIN{FS=":"}{if(NR=='$i') print $3}' ./dp/${dbname}/${tableName})
	    	
		typeset -i col_number

		while true
		do
			echo "enter column name: "
			read cname
			col_number=$(awk -F":" -v col=$cname '{
            			if ($1 == col)
                		print NR;
            		}' ./dp/$dbname/${tableName}MetaData)
		#done
			col_number=$col_number-1

			echo "$colName ($colType): "
			read data

			#typeset -i  colCondNumber
			#echo "enter column name: "
			#read cCondName
			#col_number=$(awk -F":" -v col=$cCondName '{
            		#	if ($1 == col)
                	#	print NR;
            		#}' ./dp/$dbname/${tableName}MetaData)
		
		# Validate Input
		        if [[ $colType == "int" ]]
			then
			  	while ! [[ $data =~ ^[0-9]*$ ]];
				do
					echo -e "invalid DataType !!"
					echo -e "$colName ($colType) = \c"
			       		read data
			        done
			fi

			echo "Enter data u want to update: "
			read updata
			if [ `cut -d: -f1 ./dp/${dbname}/${tableName} | grep -c -w "${updata}"` -gt 0 ];
			then
				echo " error repeated primary key"
				#read data
				exit;  
			else
				row=`cut -d: -f1 ./dp/${dbname}/${tableName} | grep -w -n "$data" | cut -d: -f1`
				echo "col-number = $col_number"	
				oldname=$(awk -v rowNum=$row 'BEGIN{FS=":"}NR==rowNum{print $'${col_number}'}' ./dp/${dbname}/${tableName})
				echo "oldname = $oldname"	
				#echo "wasalna ${tableName}"
				sed -i "s/$oldname/$updata/g" ./dp/${dbname}/${tableName}
				#sed -i $rowWillUpdateNumber"s/$updata/$data/$columnWillUpdateNumber" ./dp/${dbname}/${tableName}
				#sed "s/$data/$updata/g" ./dp/${dbname}/${tableName}
				break
			fi
		done
       done
fi
#Set row
#sed -i "s/$updata/$data/g" ./dp/${dbname}/${tableName}
#if [[ $i == $colsNum ]]
#then
#       	row=$row$data$rSep
#else
#      row=$row$data$sep
#fi
#done
#echo -e $row"\c" >> ./dp/${dbname}/${tableName}
if [[ $? == 0 ]]
then
    echo "Data Inserted Successfully"
else
    echo "Error Inserting Data into Table $tableName"

#  row=""
#echo "databse not exist"
fi
