#!/bin/sh

if [ $# != 2 ];
then
	echo "Incorrect number of arguments"
	exit 1
fi
directory=$1
outputFile=$2
tempFile="temp"
touch $tempFile
touch $outputFile
chmod 777 $tempFile
chmod 777 $outputFile
> $outputFile
> $tempFile

echo "<!DOCTYPE html>\n<html>\n<body>" >> $outputFile

find "$directory" | grep -v "\/\." | tail +2 > $tempFile

slashCount=0
lastSlashCount=0
while read line
do
	#indent or outdent(?) as needed
	slashCount=$(echo $line | grep "\/" -o | wc -l)
	if [ $lastSlashCount -lt $slashCount ]
	then
		lastSlashCount=$slashCount
		echo "<ul>" >> $outputFile
	elif [ $slashCount -lt $lastSlashCount ]
	then
		end="$(($lastSlashCount-$slashCount))"
		i=0
		#echo $end
		while [ $i -lt $end ]
		do
			i=$(($i+1))
			echo "</ul>" >> $outputFile
		done
		lastSlashCount=$slashCount
	fi	
	
	echo -n "<li>" >> $outputFile
	formatted=$(echo -n $line | grep -o "[^\/]*$" | tr '\n' ' ')
	if [ -f "$line" ]
	then
		formatted="<a href=\"$line\">$formatted</a>"
	fi
	echo $formatted >> $outputFile
	echo "</li>" >> $outputFile
done < $tempFile

echo "</body>\n</html>" >> $outputFile

rm $tempFile

#old code that wasn't super good below

#echo $output > $outputFile
#sed -i "s/\s\+/\n/g" $outputFile
#sed -i "1s/^/\<\!DOCTYPE html\>\n\<html\>\n\<body\>\n/" $outputFile
#echo "</body>\n</html>" >> $outputFile
#sed -i "s/\.\(.*\(\/.*\..*\)\)/\<p\>\<a href=\"file:\/\1\"\>\2\<a\>\<\/li\>/g" $outputFile
#sed -i "/^\./ s/[^\/]*\//    /g" $outputFile
#sed -i -e "s/[^\/]*\//   |/g" $outputFile
