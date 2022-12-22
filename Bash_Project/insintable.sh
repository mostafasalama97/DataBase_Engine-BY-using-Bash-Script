#!/usr/bin/bash

dbname=$(zenity --entry --title="Please, Enter Database Name" --text="Database Name:")

tableName=$(zenity --entry --title="Please, Enter Table Name" --text="Table Name:")

if ! [[ -f ./dp/${dbname}/${tableName}MetaData ]];
then
	zenity --error --text="Table ${tableName} doesn't exist" --no-wrap
	exit;

elif [ "$tableName" = "" ];
then
	zenity --error --text="Table Name cannot be NULL" --no-wrap
	exit;
fi

metafile=.${tableName}MetaData
echo "Enter your Data"
colsNum=$(cat ./dp/${dbname}/${tableName}MetaData| wc -l)

sep=":"
rSep="\n"
for (( i = 2; i <= $colsNum; i++ ));
do
	colName=$(awk 'BEGIN{FS=":"}{ if(NR=='$i') print $1}' ./dp/$dbname/${tableName}MetaData)
        colType=$(awk 'BEGIN{FS=":"}{if(NR=='$i') print $2}' ./dp/$dbname/${tableName}MetaData)
	primary=$(cut -d: -f3 ./dp/${dbname}/${tableName}MetaData )
        
	echo -e "$colName ($colType)"
    	read data
       	echo "./dp/${dbname}/${tableName} ${data}"
	
	if [ `cut -d: -f1 ./dp/${dbname}/${tableName} | grep -c -w "${data}"` -gt 0 ];
	then
		echo " error repeated primary key"
		#read data
		exit;
	fi
    
    	if [[ $colType == "int" ]]; 
	then
	      	while ! [[ $data =~ ^[0-9]*$ ]]; 
		do
		      	echo -e "invalid DataType !!"
	          	echo -e "$colName $colType "
      			read data	
		done

	elif [[ $colType == "string" ]]; 
	then
		while  [[ ! $data =~ ^[a-zA-Z]*$ ]] || [[ $data == "" ]]; 
		do
		       	echo -e "invalid DataType !!"
			echo -e "$colName $colType "
          		read data
		done
	fi
    
	if [[ $i == $colsNum ]];
	then
		row=$row$data$rSep
    	else
	       	row=$row$data$sep
	fi
done

echo -e $row"\c" >> ./dp/$dbname/$tableName
if [[ $? == 0 ]]
then
	echo "Data Inserted Successfully"
     	#     . ../.././crud.sh
else
  	echo "Error Inserting Data into Table $tableName"
       	#    . ../.././crud.sh
fi

row=""
