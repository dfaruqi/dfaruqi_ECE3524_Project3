#!/bin/sh
choice=0
while [ "$choice" != 10 ]
do
	date
	echo '--------------------------------'
	echo ' Main Menu'
	echo '--------------------------------'
	echo '1. Operating system info'
	echo '2. Hostname and DNS info'
	echo '3. Network info'
	echo '4. Who is online'
	echo '5. Last logged in users'
	echo '6. My IP address'
	echo '7. My disk usage'
	echo '8. My home file-tree'
	echo '9. Process operations'
	echo '10. Exit'
	echo -n 'Enter your choice [ 1-10 ] '
	read choice

	case $choice in
		1)
			echo '--------------------------------'
			echo ' System Information'
			echo '--------------------------------'
			/usr/bin/lsb_release -a
		;;
		2)
			echo '--------------------------------'
			echo ' Hostname and DNS information'
			echo '--------------------------------'
			echo -n 'hostname : '
			hostname
			echo -n 'DNS domain : '
			domainname
			echo -n 'Fully qualified domain name : '
			hostname -f
			echo -n 'Network address (IP) : '
			hostname -i
			echo -n 'DNS name servers (DNS IP) : '
			grep "nameserver" /etc/resolv.conf | grep -o "[0-9].*[0-9]"
		;;
		3)
			echo '--------------------------------'
			echo ' Network information'
			echo '--------------------------------'
			echo -n 'Total number of interfaces found : '
			ls -A /sys/class/net | wc -l
			ip addr show
			echo '********************************'
			echo '********Network routing*********'
			echo '********************************'
			netstat -r
			echo '********************************'
			echo '*Interface traffic Information**'
			echo '********************************'
			netstat -i
		;;
		4)
			echo '--------------------------------'
			echo ' Who is online '
			echo '--------------------------------'
			who -H
		;;
		5)
			echo '--------------------------------'
			echo ' List of last logged in users '
			echo '--------------------------------'
			last
		;;
		6)
			echo '--------------------------------'
			echo ' Public IP information '
			echo '--------------------------------'
			host myip.opendns.com resolver1.opendns.com | grep "has address" | grep -o "[0-9].*[0-9]"
		;;
		7)
			echo '--------------------------------'
			echo ' Disk Usage Info '
			echo '--------------------------------'
			df | grep -o "[0-9]%.*"
		;;
		8)
			./proj1.sh /home/ filetree.html
		;;
		9)
			./proc.sh
		;;
	esac
	
	if [ "$choice" != 10 && "$choice" != 9 ]
	then
		read -p 'Press [Enter] to continue...' continue
	fi
	
done
