#!/bin/bash

declare -A months=([Jan]=01 [Feb]=02 [Mar]=03 [Apr]=04 [May]=05 [Jun]=06 [Jul]=07 [Aug]=08 [Sep]=09 [Oct]=10 [Nov]=11 [Dec]=12)

echo "--------Report ($(date))------------" > report;
echo "" >> report

for folder in {video,image};
do 	
		echo "-------------------(start of $folder)-------------------------" >> report
		echo "------------------------------------------------------" >> report
		num=0
		for file in $(ls $folder);
		do
				((num+=1))
				json_file=$(find ./meta -iname "$file.json")
				if [ "$json_file" != '' ]
				then

						timestamp=$(jq '.["photoTakenTime"].["formatted"]' $json_file)
						date=$(echo $timestamp | awk -F, '{print $1}')
						month=${months[$(echo $date | awk '{print $1}' | sed s/\"//g)]}
						day=$(echo $date | awk '{print $2}')
						year=$(echo $timestamp | awk '{print $3}' | sed s/,//g)
						time=$(echo $timestamp | awk '{print $4}' | sed s/AM//g | sed s/PM//g | awk -F" " '{print $1}')
						timestamp="$year-$month-$day $time"


						echo "File: $file" >> report
						echo "From:$(stat $folder/$file | grep "Modify" | awk -F"." '{print $1}' | sed s/Modify://g)" >> report
						echo "To: $timestamp" >> report
						echo "JSON file: $json_file" >> report
						echo "------------------------------------------------------" >> report

						touch --date=$timestamp $folder/$file

				fi
		done
		echo "-------------------(end of $folder)-------------------------" >> report
		echo "" >> report

done

