#!/bin/bash

# Удаляю лишние файлы перед созданием нового
rm -f *.status

search() {
	hostname | awk '{print "HOSTNAME = " $0}'
	timedatectl | awk '{print "TIMEZONE = " $3 $4 $5}' | grep '/'
	echo "$USER" | awk '{print "USER = " $0}'
	cat /etc/issue | sed -r '/^\s*$/d' | awk '{print "OS = " $1,$2,$3}'
	date | awk '{print "DATE = " $2,$3,$4,$5}'
	uptime | awk '{print "UPTIME = " $3}'
	cat /proc/uptime | awk '{print "UPTIME_SEC = " $1}'
	ifconfig | grep inet -m 1 | awk '{print "IP = " $2}'
	ifconfig | grep netmask -m 1 | awk '{print "MASK = " $4}'
	ip route | grep via -m 1 | awk '{print "GATEWAY = " $3}'
	free -m | awk '/Mem:/{printf "RAM_TOTAL = %.3f Gb\n", $2/1024}'
	free -m | awk '/Mem:/{printf "RAM_USED = %.3f Gb\n", $3/1024}'
	free -m | awk '/Mem:/{printf "RAM_FREE = %.3f Gb\n", $4/1024}'
	df /root/ | awk '/\/$/  {printf "SPACE_ROOT = %.2f MB\n", $2/1024}'
	df /root/ | awk '/\/$/  {printf "SPACE_ROOT_USED = %.2f MB\n", $3/1024}'
	df /root/ | awk '/\/$/  {printf "SPASE_ROOT_FREE = %.2f MB\n", $4/1024}'
}

if [ $# -ne 0 ]; then 
	echo -e "ERROR: too many arguments"
else 
	read -p "Вы действильно хотите сохранить эту информацию?(Y/n)" confim
	if [[ $confim == y || $confim == n ]]; then
		search > "$(date +"%d_%m_%y_%H_%M_%S").status"
	else
		search  >&1
	fi
fi