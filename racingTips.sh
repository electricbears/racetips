#!/bin/bash

. ~mark/bin/common.sh

singular -k

[ "$1" != "--refresh-html" ] && getOlgb.sh --data > ~/bin/data/racetips.txt 2>/dev/null

# Save tips for races about to be run
getTipsUpdateResults.sh 2>/dev/null

# Match results to saved tips
checkResults.sh 2>/dev/null

# Generate tips
echo "Generating tips...."
generateTipsHTML.sh >/tmp/tips.html 2>/dev/null
echo "Transfering tips.html"
scp /tmp/tips.html ${WEBHOSTUSER}@${WEBHOSTDOMAIN}:~/electricbears.com/tips/index.html 2>/dev/null

# Generate results
echo "Generating results...."
generateResultsHTML.sh >/tmp/results.html 2>/dev/null
echo "Transfering results.html"
scp /tmp/results.html ${WEBHOSTUSER}@${WEBHOSTDOMAIN}:~/electricbears.com/results/index.html 2>/dev/null

# Generate results with popovers
echo "Generating popover results...."
generateResultsHTML2.sh >/tmp/pop.html 2>/dev/null
echo "Zipping files"
zip -j /tmp/results-popover/popover.zip /tmp/results-popover/*.html
echo "Transfering pop.html"
scp /tmp/pop.html ${WEBHOSTUSER}@${WEBHOSTDOMAIN}:~/electricbears.com/results/pop.html 2>/dev/null
echo "Transfering popover zip"
scp /tmp/results-popover/popover.zip ${WEBHOSTUSER}@${WEBHOSTDOMAIN}:~/electricbears.com/results/popover/ 2>/dev/null
echo "Unzipping."
ssh ${WEBHOSTUSER}@${WEBHOSTDOMAIN} unzip -o electricbears.com/results/popover/popover.zip -d electricbears.com/results/popover/

exit

#### More old stuff
scp /tmp/results-popover/*.html ${WEBHOSTUSER}@${WEBHOSTDOMAIN}:~/electricbears.com/results/popover/ 2>/dev/null
echo "<html><pre>" > /tmp/results.html
sort -n -r ~/bin/data/racesandresults.txt|awk -F"|" '{printf "%s %s\nTipped: %s (%s)\nWinner: %s\n\n", $2, $3, $5, $23, $24}'|sed "s/Winner: $/Winner: TBD/" >> /tmp/results.html
echo "</pre></html>" >> /tmp/results.html

