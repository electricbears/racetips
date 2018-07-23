# racetips

allModels.sh         - runs through each model defined in raceModels.sh and generates the win/lose stats
   raceModels.sh     - include file with 1 bash function per model
   winRate.sh        - used to sumerise race model output into win/lose stats
checkResults.sh      - pulls latest results from sporting life and updates the data file
generateResultsHTML2.sh - runs through the data file and generates HTML +popover file for details on each result
   popover-script.js    - JS for above to do popovers
generateTipsHTML.sh     - as above for tips using the tips data file?
getOlgb.sh              - *** scrapes from OLBG, racing post and at the races <-- this does mosts of the data collection
getTipsUpdateResults.sh - runs through the tips file, send notifications if appropriate and writes details into results data file
racingTips.sh           - Driver script to run the above
