#!/usr/bin/env bash

if [ -n "$1" ];then
    if [ -f "$1" ]; then 

	time_list="$(cat $1 | cut -d '-' -f 2 | tr -ds ' ' "\n" | sort)";
	days="";
	hours="";
	weeks="";
	months="";
	years="";

	for tm in ${time_list[@]};do
	    tmp=$(echo $tm | awk '{print substr($0,1,length-1)}');
	    case "${tm: -1}" in
		d)
		    let "days += tmp";
		    ;;
		h)
		    let "hours += tmp";
		    ;;
		w)
		    let "weeks += tmp";
		    ;;
		m)
		    let "months += tmp";
		    ;;
		y)
		    let "years += tmp";
		    ;;
		*)
		    echo "I dunno: -> ${tm} <-";
		    ;;
	    esac
	done;

	echo "project total: h:$hours, d:$days, w:$weeks, m:$months, y:$years";
	exit 0;
    fi
fi

cat << USAGE 
usage: $(basename "$0") [filename] 

Where filename must contain a valid file to calculate project time from
The time file must be formatted as:

time := n + (h|d|w|m|y)

n := decimal number indicating the time
h := hour(s)
d := day(s)
w := week(s)
m := month(s)
y := year(s)

On seperate lines.

Where:

n is a number of the respective time, indicated in decimal. 
h is short for hours
d is days
w is weeks
m is months
y is years

Example file: 
2h
1d
4w
9m
3y 
USAGE

exit 1
