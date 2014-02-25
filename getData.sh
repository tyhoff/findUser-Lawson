#!/bin/sh

# to run who on each Lawson lab computer
# 
# Credit goes to Eric Templin for use of his bell 
# ringer code

function findUser {
	STR1=`ssh $1 "who -s" 2> /dev/null`
	echo -e "@$1\n$STR1"
}

#Cycle through all the machines and run findUser on each
for HOST in moore{00..24} sslab{00..24} borg{00..21} xinu{00..21} sac{01..13} pod{1..5}-{1..5} pod0-0 mc{01..18} lore data xena pc; 
do
	sleep .01
	findUser ${HOST} &
done

sleep 2 
kill -9 $$
