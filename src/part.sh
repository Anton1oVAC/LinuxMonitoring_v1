#!/bin/bash

echo "Введи кол-во заданий:"
read count

# Проверка на число
if ! [[ $count =~ ^[0-9]+$ ]] || [ $count -lt 0 ]; then
	echo "Ошибка!"
	exit 1
fi

for ((i = 0; i <= $count; i++))
do
	folder="part$(printf "%02d" $i)"
	mkdir -p "$folder"
done
