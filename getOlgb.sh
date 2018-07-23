#!/bin/bash

# Standard
respJSON=$(curl --silent 'https://tips.olbg.info/sports/Horse_Racing/top_tips?paginate=1-50&include_recommendations=1&ti=679e6505d47bf3dce7f754be79ee1faf1505812911:ouk1.0:Safari:1196,403:10.1.1&source=&api_key=S6H8MM3KN52Q8KN8&bookie_name=_best_&client_type=desktop_website' \
-XGET \
-H 'DNT: 1' \
-H 'Referer: https://www.olbg.com/betting-tips/Horse_Racing/2' \
-H 'Origin: https://www.olbg.com' \
-H 'Accept: application/json, text/plain, */*' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4'|jq ".tips|=sort_by(.event_start_unix_timestamp)")

# ** HOT TIPS ONLY ** Order: event_start, total_tip
#respJSON=$(curl --silent 'https://tips.olbg.info/tips/hot?paginate=1-50&having%5B%5D=(sport_alias)(eq)Horse%20Racing&having%5B%5D=(confidence)(gteq)50&having%5B%5D=(odds)(gteq)0.00&having%5B%5D=(win_tips)(gteq)2&rorder=event_start&ti=679e6505d47bf3dce7f754be79ee1faf1505812911:ouk1.0:Safari:1196,403:10.1.1&source=&api_key=S6H8MM3KN52Q8KN8&bookie_name=_best_&client_type=desktop_website' \
#-XGET \
#-H 'DNT: 1' \
#-H 'Referer: https://www.olbg.com/betting-tips/Horse_Racing' \
#-H 'Origin: https://www.olbg.com' \
#-H 'Accept: application/json, text/plain, */*' \
#-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4')

	racingPostNapJSON=$(curl --silent "https://www.racingpost.com/tipping/naps-table/"|grep "naps-table.*data.*horse"|sed "s/.*STATE = {\(.*\)}.*/{\1/g")

numberTips=$(echo $respJSON|jq ".tips | length")
[ $numberTips -eq 0 ] && echo "No tips."

for ((i=0;i<$numberTips;i++))
do
	#thisJSON=$(echo $respJSON|jq ".tips[$i]")
	race=$(echo $respJSON|jq -r ".tips[$i].eventname")

	# If race is blank then must be a data issue so skip it
	[ "$race" == "" ] && continue
	location=$(echo $respJSON|jq -r ".tips[$i].subsport_hash")
	raceEpochTime=$(echo $respJSON|jq -r ".tips[$i].event_start_unix_timestamp")
	raceDT=$(date -j -f %s $(echo $respJSON|jq -r ".tips[$i].event_start_unix_timestamp") +"%d/%m/%Y %H:%M")
	if [ ${raceDT:0:2} -gt $(date +%d) ]
	then
		atrSuffix="/tomorrow"
	else
		atrSuffix=""
	fi
	
	name=$(echo $respJSON|jq -r ".tips[$i].selection")
	fractional_odds=$(echo $respJSON|jq -r ".tips[$i].fractional_odds")
	odds=$(echo $respJSON|jq -r ".tips[$i].odds")
	confidence=$(echo $respJSON|jq -r ".tips[$i].confidence")
	confidence_nap=$(echo $respJSON|jq -r ".tips[$i].confidence_nap")
	confidence_ew=$(echo $respJSON|jq -r ".tips[$i].confidence_ew")
	win_tips_count=$(echo $respJSON|jq -r ".tips[$i].win_tips_count")
	win_tips=$(echo $respJSON|jq -r ".tips[$i].win_tips")
	nap_tips_count=$(echo $respJSON|jq -r ".tips[$i].nap_tips_count")
	nap_tips=$(echo $respJSON|jq -r ".tips[$i].nap_tips")
	ew_tips_count=$(echo $respJSON|jq -r ".tips[$i].ew_tips_count")
	ew_tips=$(echo $respJSON|jq -r ".tips[$i].ew_tips")
	HORSE=$(echo $name|tr '[:lower:]' '[:upper:]')
	atrURL="www.attheraces.com/tips/race-by-race-guides/${location/ /-}${atrSuffix}"
	racingPostNap=$(echo $racingPostNapJSON|jq -r --arg horse "$name" '[.|.data[] | select(.horseName==$horse)][0].tipster'|sed "s/null//")
	racingPostLevelStakes=$(echo $racingPostNapJSON|jq -r --arg horse "$name" '[.|.data[] | select(.horseName==$horse)][0].levelStakes'|sed "s/null//")

	# ATR
	curl --silent "www.attheraces.com/tips/race-by-race-guides/$location${atrSuffix}" > /tmp/atr.txt
	export atrTipType=""
	export tipOnATR="No"
	while read linenum
	do
		tmp_atrTipType=$(head -$linenum /tmp/atr.txt |tail -2|head -1|egrep -e "(Top Tip|Watch out for)"|sed -e "s/^ *//g" -e "s/:.*//g")
		echo "$tmp_atrTipType" |grep -iq "Top Tip" && atrTipType="Top tip" && tipOnATR="Yes"
		echo "$tmp_atrTipType" |grep -iq "Watch Out" && atrTipType="Watch" && tipOnATR="Yes"
	done <<< "$(grep -n "${HORSE}" /tmp/atr.txt |cut -d":" -f1)"

	#tipOnATR=$(cat /tmp/atr.txt|grep -q "${HORSE}" && echo "Yes" || echo "No")

	message="Nope (0)"
	[ $confidence -gt 60 ] && \
	[ $win_tips_count -gt 7 ] && \
		message="Good (1)" && \
	[ "$tipOnATR" == "Yes" ] && \
		message="Better (2)" && \
	[ ! -z "$racingPostNap" ] && \
		message="Best (3)" && \
	[ ${racingPostLevelStakes/\./} -gt 0 ] && \
		message="Bestest (4)"
	
	if [ "$1" != "--data" ]
	then
   	echo "Race: $race ($raceDT)"
   	echo "	Horse: $name"
   	echo "	Odds: $odds ($fractional_odds)"
   	echo "	Suffix: $atrSuffix"
   	echo "	Confidence: $confidence"
   	echo "	Nap confidence: $confidence_nap"
   	echo "	Each way confidence: $confidence_ew"
   	echo "	$win_tips of $win_tips_count Win Tips"
   	echo "	$nap_tips of $nap_tips_count Nap Tips"
   	echo "	$ew_tips of $ew_tips_count each way Tips"
		echo "	ATR: $tipOnATR"
		echo "	ATR Tip Type: $atrTipType"
		echo "	URL: $atrURL"
		echo "	Racing post naps: $racingPostNap"
		echo "	Racing post level stakes: $racingPostLevelStakes"
		echo "	Conclusion: $message"
		echo
	else
   	echo "${raceEpochTime}|${race}|${raceDT/ /|}|${name}|${odds}|${fractional_odds}|${atrSuffix}|${confidence}|${confidence_nap}|${confidence_ew}|${win_tips}|${win_tips_count}|${nap_tips}|${nap_tips_count}|${ew_tips}|${ew_tips_count}|${tipOnATR}|${atrTipType}|${atrURL}|${racingPostNap}|${racingPostLevelStakes}|${message}"
	fi
	
done
