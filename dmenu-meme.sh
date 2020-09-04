#!/bin/bash

# Simple meme maker using dmenu made in bash

# Path to your module folder and tmp folder
moudles_path="./memes/"
temp_path="/tmp/meme"

prop=$(<$moudles_path/$(ls $moudles_path | dmenu -i -l 15 -p "Choose a template:"))
wget -O "$temp_path" $(echo "$prop" | awk 'NR==1{print $1}')

echo "$prop" | tail -n +2 | while read line
do
	text=$(""|dmenu -p "Text to be placed at: $line")
	convert -font helvetica -fill white -pointsize 30 -draw "text $line '$text'" $temp_path $temp_path
done

dragon-drag-and-drop "$temp_path"
