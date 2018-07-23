# racetips
<ul>
<li>allModels.sh         - runs through each model defined in raceModels.sh and generates the win/lose stats</li>
<ul>
   <li>raceModels.sh     - include file with 1 bash function per model</li>
   <li>winRate.sh        - used to sumerise race model output into win/lose stats</li>
</ul>
<li>checkResults.sh      - pulls latest results from sporting life and updates the data file</li>
<li>generateResultsHTML2.sh - runs through the data file and generates HTML +popover file for details on each result</li>
<ul>
   <li>popover-script.js    - JS for above to do popovers</li>
</ul>
<li>generateTipsHTML.sh     - as above for tips using the tips data file?</li>
<li>getOlgb.sh              - <strong>*** scrapes from OLBG, racing post and at the races - this does mosts of the data collection</strong></li>
<li>getTipsUpdateResults.sh - runs through the tips file, send notifications if appropriate and writes details into results data file</li>
<li>racingTips.sh           - Driver script to run the above</li>
</ul>
