#!/bin/sh

# to run who on each Lawson lab computer
# 
# Credit goes to Eric Templin for use of his bell 
# ringer code

function findUser {
	STR1=`ssh $1 who -s`
	echo -e "@$1\n$STR1"
}


#Cycle through all the machines and run findUser on each

for id in {01..13}; do
	findUser sac${id} &
done

for host in moore sslab; do
	for id in {00..24}; do
		findUser ${host}${id} &
	done
done

for i in {1..5}; do
	for j in {1..5}; do
		findUser pod${i}-${j} &
	done
done

sleep 2 
kill -9 $$