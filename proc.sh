#!/bin/bash
choice=0
while [ "$choice" != 4 ]
do
	choice=0
	leave=0
	printf "(please enter the number of your selection below)\n\n"
	printf "1.	Show all processes\n"
	printf "2.	Kill a process\n"
	printf "3.	Bring up top\n"
	printf "4.	Return to main menu\n\n"

	read choice

	case $choice in
			1)
				ps -ef
			;;
			2)
				pid=0
				echo "Please enter the PID of the process you would like to kill: "
				read pid
				
				kill -9 $pid
			;;
			3)
				top
			;;
			*)
			continue
			;;
	esac
	
	while [ $leave != ":q" ]
	do
		read -n 2 leave
	done
done
