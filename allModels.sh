#!/bin/bash

. ~mark/bin/raceModels.sh
HTML_OUTPUT="/tmp/allmodels.html"
echo "<pre>" > "${HTML_OUTPUT}"

declare -F|sed "s/.*model_\(.*\)/\1/g"|
while
	read modelVer
do
	type "model_${modelVer}"|grep -v "is a function"|tee -a "${HTML_OUTPUT}"
	runRaceRules.sh $modelVer|winRate.sh -|tee -a "${HTML_OUTPUT}"
done

nohup scp "${HTML_OUTPUT}" ${WEBHOSTUSER}@${WEBHOSTDOMAIN}:~/electricbears.com/results/ >/dev/null 2>/dev/null &
