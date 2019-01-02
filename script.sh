#!/bin/bash

read -p "Enter Url : " url

length_of_each_part = `curl -sI "$url" | grep "Content-Length" | awk '{print $2/10}'`

read -p "Download Path ? " download_path

for (( i = 1, start = 0, end = $length_of_each_part ; i < 11 ; i++ ))
do
    curl -s --range $start-$end -o "$download_path"/file.part."$i" "$url" &
    start=$((end+1))
    end=$((end+length_of_each_part))
done

read -p "File Name ? " file_name

`cat "$download_path"/file.part.? > "$file_name"`
