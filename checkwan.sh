#!/bin/sh
#脚本放/bin目录，再用命令运行nohup sh /bin/checkwan.sh  1>/dev/null 2>&1 &

echo '脚本检测开始'
tries=0
wan=`ifconfig |grep inet| sed -n '1p'|awk '{print $2}'|awk -F ':' '{print $2}'`
while true
do
# do something
if ping -w 1 -c 1 119.29.29.29; then #ping dns通则
	echo '网络正常'
	tries=0
else
	sleep 1
	if ping -w 1 -c 1 $wan; then #若ping网关通则
		echo '网关正常'
		tries=$((tries+1))
	else #ping不通，重启防火墙
		echo '网络崩溃重启防火墙'
		/etc/init.d/firewall reload
		sleep 10
	fi
	if [ $tries -ge 5 ]; then #连续ping dns 5次失败，重启wan口
		tries=0
		/etc/init.d/network restart
		sleep 5
	fi
fi
sleep 2
done
