#!/bin/sh
TIME=$(((`date +%H`*3600)+(`date +%M`*60)+`date +%S`))
if [ $TIME -ge 14400 ]; then # 凌晨4点的秒数14400秒，次日凌晨4点的秒数100800秒
	SECOND=$((100800-TIME))
else
	SECOND=$((14400-TIME))
fi
sleep $SECOND
/etc/init.d/network restart
