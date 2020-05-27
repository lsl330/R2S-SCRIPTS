#!/bin/sh
HOUR=$(expr `date +%H` \* 3600)
MINUTE=$(expr `date +%M` \* 60)
SECOND=`date +%S`
TIME=$(expr $HOUR + $MINUTE + $SECOND)
if [ $TIME -ge 14400 ]; then # 凌晨4点的秒数14400秒，次日凌晨4点的秒数100800秒
	SECOND=$(expr 100800 - $TIME)
else
	SECOND=$(expr 14400 - $TIME)
fi
sleep $SECOND
/etc/init.d/network restart
