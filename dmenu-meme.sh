#!/bin/bash

# Simple meme maker using dmenu made in bash

# Path to your module folder and tmp folder
moudles_path="./memes/"
temp_path="/tmp/meme"

prop=$(<$moudles_path/$(ls $moudles_path | dmenu -i -l 15 -p "Choose a template:"))
wget -O "$temp_path" $(echo "$prop" | awk 'NR==1{print $1}')

echo "$prop" | tail -n +2 | while read line
do
	pos=$(echo $line | awk '{print $1}')
	size=$(echo $line | awk '{print $2}')
	color=$(echo $line | awk '{print $3}')
	font=$(echo $line | awk '{print $4}')
	text=$("" | dmenu -p "Text to be placed at: '$pos'")
	
	convert -font ${font:-helvetica} -fill ${color:-white} -pointsize ${size:-30} -draw "text ${pos:-0,0} '${text:-SAMPLE TEXT}'" $temp_path $temp_path
done

dragon-drag-and-drop "$temp_path"
