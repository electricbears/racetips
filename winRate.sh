#!/bin/bash

. ~mark/bin/common.sh

RACES_AND_RESULTS_FILE="${COMMON_DATA_DIR}/racesandresults.txt"

[ "$1" == "-" ] && RACES_AND_RESULTS_FILE=""

cat ${RACES_AND_RESULTS_FILE}|awk -F"|" '
BEGIN {wins=0;winners=0;biggest=0}
{
	if ( $23 == "Nope (0)" ) {next};
	if ( $24 == "" ) {next};
	if ( $5 == $24 ) {wins=wins + $6;winners++};
	if ( $5 == $24 && $6 > biggest) {biggest=$6};
	if ( $5 != $24 ) {loses=loses + 1};
	bets++;
}
END {printf "Wins: %0.2f, Stake: %0.2f, Profit: %0.2f, Win rate: %d/%d (%d%%), Biggest: %d\n", wins, bets, wins - bets, winners, winners + loses, winners/(winners + loses)*100, biggest}'
