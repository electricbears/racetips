#!/bin/bash

. ~mark/bin/common.sh

echo "<html>"
echo '<head><style>
	#myTable {
		border-collapse: collapse;
		width: 100%;
		border: 1px solid #ddd;
		font-size: 18px;
	}

	#myTable th, #myTable td {
		border: 1px solid #ddd;
		text-align: left;
		padding: 12px;
	}

	#myTable tr {
		border-bottom: 1px solid #ddd; 
	}

	#myTable tr.header, #myTable tr:hover {
		background-color: #f1f1f1;
	}
	#myTable tr.good {
		background-color: #d9f2e6;
	}

	#myTable tr.better {
		background-color: #9fdfbf;
	}

	#myTable tr.best {
		background-color: #53c68c;
	}

	#myTable tr.bestest {
		background-color: #2d8659;
	}'
echo '</style></head>'
echo "<pre>$(date): $(winRate.sh)</pre>"
echo '<table id="myTable"> 
  <tr class="header">
    <th style="width:15%;">Race</th>
    <th style="width:15%;">Horse</th>
    <th style="width:9%;">Odds</th>
    <th style="width:7%;">Confidence</th>
    <th style="width:15%;">Tips</th>
    <th style="width:7%;">ATR</th>
    <th style="width:15%;">Racing Post</th>
    <th style="width:7%;">Conclusion</th>
  </tr>'
#1  ${raceEpochTime}|
#2  ${race}|
#3  ${raceDT/ /|}|
#4  ${raceDT/ /|}|
#5  ${name}|
#6  ${odds}|
#7  ${fractional_odds}|
#8  ${atrSuffix}|
#9  ${confidence}|
#10 ${confidence_nap}|
#11 ${confidence_ew}|
#12 ${win_tips}|
#13 ${win_tips_count}|
#14 ${nap_tips}|
#15 ${nap_tips_count}|
#16 ${ew_tips}|
#17 ${ew_tips_count}|
#18 ${tipOnATR}|
#19 ${atrTipType}|
#20 ${atrURL}|
#21 ${racingPostNap}|
#22 ${racingPostLevelStakes}|
#23 ${message}
sort -n  ~/bin/data/racetips.txt|awk -F"|" '
	{
      class="";
      if ( $23 ~ /Good/ ) { class="good" }
      if ( $23 ~ /Better/ ) { class="better" }
      if ( $23 ~ /Best/ ) { class="best" }
      if ( $23 ~ /Bestest/ ) { class="bestest" }
		printf "\
				<tr class='%s'>\
					<td>%s (%s %s)</td>\
					<td>%s</td>\
					<td>%s (%s)</td>\
					<td>Win: %s%%</br>Nap: %s%%</br>EW: %s%%</br></td>\
					<td>%s of %s Win Tips</br>%s of %s Nap Tips</br>%s of %s each way Tips</td>\
					<td>%s</td>\
					<td>%s</br>%s</td>\
					<td>%s</td>\
				</tr>", class, $2, $3, $4, $5, $6, $7, $9, $10, $11, $12, $13, $14, $15, $16, $17, $19, $21, $22, $23
	}
'
echo "</table></html>"
