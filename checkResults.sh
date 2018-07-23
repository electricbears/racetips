#!/bin/bash

curl --silent https://www.sportinglife.com/api/horse-racing/fast-result|jq --raw-output '.[] | .top_horses[0].horse_name + "|" +  .courseName + "|" + .time'|sed "s/ ([A-Z]*)|/|/"|
while
	read result
do
	#echo $result
	horse=$(echo $result|cut -d"|" -f1)
	track=$(echo $result|cut -d"|" -f2)
	time=$(echo $result|cut -d"|" -f3)
	fixedTime=$(date -jf"%H:%M %Z" "$time GMT" +%H:%M)
	event="$(date -jf"%H:%M %Z" "$time GMT" +%l:%M|sed "s/^ //") $track"
	date=$(date +%d/%m/%Y)
	sedDate=$(date +%d.%m.%Y)

	#echo $fixedTime
	#echo $event - $horse
	[ "$horse" == "" ] && continue

	#grep "$event|$date|$fixedTime" ~/bin/data/racesandresults.txt 
	grep  -q "$event|$date|$fixedTime" ~/bin/data/racesandresults.txt && sed -i -e "s/\([0-9]*|${event}|${sedDate}|${fixedTime}.*|$\)/\1${horse}/g" ~/bin/data/racesandresults.txt
	
done
