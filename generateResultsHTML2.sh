#!/bin/bash

. ~mark/bin/common.sh

# Dir to hold popover data
mkdir /tmp/results-popover 2>/dev/null

echo "<html>"
echo '<head>
  <meta http-equiv="pragma" content="no-cache"><meta http-equiv="cache-control" content="no-store,no-cache">
  <meta charset="utf-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style>
.popover{
    max-width: 100%;
}
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
	#myTable tr.right {
		background-color: #99ff99;
	}

	#myTable tr.missed {
		background-color: #ffeb99;
	}

	#myTable tr.wrong {
		background-color: #ff9999;
	}'
echo '</style></head>'
echo '<div class="container">'
echo "<pre>$(date): $(winRate.sh)</pre>"
echo '<table id="myTable"> 
  <tr class="header">
    <th style="width:30%;">Event</th>
    <th style="width:10%;">Date</th>
    <th style="width:22%;">Tipped</th>
    <th style="width:6%;">Odds</th>
    <th style="width:10%;">Tip Type</th>
    <th style="width:22%;">Winner</th>
  </tr>'
epochNow=$(date +%s)
sort -n -r ~/bin/data/racesandresults.txt|awk -F"|" -v cacheBuster=$epochNow '
	BEGIN {counter=1}
	{
		class="";
		if ( $5 == $24 && $23 ~ /[BG]/ ) { class="right" }
		if ( $5 == $24 && $23 ~ /N/ ) { class="missed" }
		if ( $24 != "" && $5 != $24 && $23 ~ /B/ ) { class="wrong" }
		popover_file=sprintf("/tmp/results-popover/%d.html",counter);

		printf "\
				<tr class='%s'>\
					<td><a title=\"%s - %s\" data-templatefile=\"popover/%d.html?%d\" data-toggle=\"popover\">%s</a></td>\
					<td>%s</td>\
					<td>%s</td>\
					<td>%s</td>\
					<td>%s</td>\
					<td>%s</td>\
				</tr>", class, $2, $5, counter++, cacheBuster, $2, $3, $5, $6, $23, $24;

		printf "\
				<meta http-equiv=\"pragma\" content=\"no-cache\"><meta http-equiv=\"cache-control\" content=\"no-store,no-cache\">\
				<body>\
					<table>\
						<tr>\
							<th style=width:25%%;>Confidence</th>\
							<th style=width:25%%;>Tips</th>\
							<th style=width:25%%;>ATR</th>\
							<th style=width:25%%;>Racing Post</th>\
						</tr>\
						<tr>\
							<td>Win: %s%%</br>Nap: %s%%</br>EW: %s%%</td>\
							<td>%s of %s Win Tips</br>%s of %s Nap Tips</br>%s of %s each way Tips</td>\
							<td>%s</td>\
							<td>%s</br>%s</td>\
						</tr> \
					</table> \
				</body>", $9, $10, $11, $12, $13, $14, $15, $16, $17, $19, $21, $22 > popover_file;
		close(popover_file);
	}
'
echo "</table></div>"
cat ~mark/bin/popover-script.js
echo "</html>"
