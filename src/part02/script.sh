#!/bin/bash

echo "Введи:"
read info

echo "Вы действильно хотите сохранить эту информацию?(Y/n)"
read confim

# Проверяем ответ пользователя
case $confirm in
    [Yy]* )
        filename="$(date +%d_%m_%y_%H_%M_%S).status"
        
		timezone=$(date | cut -d' ' -f6)
		offset=$(date +%z)

		formatted_timezone="TIMEZONE = ${timezone} UTC ${offset}"
		
        echo "$info" > "$filename"
        echo "HOSTNAME = $(hostname)" >> "$filename"
        echo "${formatted_timezone}" >> "$fimename"
        echo "Сохранение $filename"
        ;;
    * )
        echo "Операция отменена."
        ;;
esac