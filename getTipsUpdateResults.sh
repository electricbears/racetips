#!/bin/bash

. ~mark/bin/common.sh

TIPS_FILE="${COMMON_DATA_DIR}/racetips.txt"
RACES_AND_RESULTS_FILE="${COMMON_DATA_DIR}/racesandresults.txt"
now30Mins=$(date -v+30M +%s)

# Get race tips and save those which are about to run
cat "${TIPS_FILE}"|
while
	read tip
do
	# Ignore anything > 30 mins time)
	raceTimeEpoch=$(echo $tip|cut -d"|" -f1)
	[ "${raceTimeEpoch}" -gt "${now30Mins}" ] && continue
	#echo "${raceTimeEpoch}"
	#echo "${now30Mins}"

	# Data needed to preserve
	race=$(echo $tip|cut -d"|" -f2)
	raceDate=$(echo $tip|cut -d"|" -f3)
	raceTime=$(echo $tip|cut -d"|" -f4)
	horse=$(echo $tip|cut -d"|" -f5)
	conclusion=$(echo $tip|cut -d"|" -f23)
	odds=$(echo $tip|cut -d"|" -f6)
	tipType=$(echo ${conclusion}|cut -d" " -f1)
	record="${raceTimeEpoch}|${race}|${raceDate}|${raceTime}|${horse}"
	
	# Check if it's already in the output file, if not write it out
	#grep -q "${record}" "${RACES_AND_RESULTS_FILE}" || echo "${tip}|" >> "${RACES_AND_RESULTS_FILE}"
	grep -q "${record}" "${RACES_AND_RESULTS_FILE}"
	if [ $? -ne 0 ]
	then
		echo "${tip}|" >> "${RACES_AND_RESULTS_FILE}"
		#[ "${tipType}" != "Nope" ] && prowly -k ${PROWL_API_KEY} -e "" -d "${race}, ${horse}, ${odds}" -a "Race tip (${tipType}):"
		#[ "${tipType}" != "Nope" ] && slack.sh -w rt -t "Race tip (${tipType}): ${race}, ${horse}, ${odds}" -c "tips"
		[ "${tipType}" != "Nope" ] && mqtt_pub -t "racing/next tip" -m "Race tip (${tipType}): ${race}, ${horse}, ${odds}"
	fi
	
	#echo "${race}, ${horse} ${odds}. ${tipType}"
done


exit
# Pull results and update previously saved tips if found
curl --silent https://www.sportinglife.com/api/horse-racing/fast-result|jq --raw-output '.[] | .top_horses[0].horse_name + "|" +  .courseName + "|" + .time'|sed "s/ ([A-Z]*)|/|/"|
while
	read result
do
	
