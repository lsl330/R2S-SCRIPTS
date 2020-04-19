#!/bin/sh
checknet=0; 

while [ $checknet -eq 0 ]
	do
		echo
		echo "...........欢迎使用 R2S 一键升级脚本.........."
		echo " 1. 写入防掉线脚本并于凌晨4点重启网络（开机自动运行）"
		echo
		echo " 2. 写入防掉线脚本（开机自动运行）"
		echo
		echo " 3. 不写入"
		echo
		echo
		read -p "$(echo -e "请选择 [\e[95m1-2\e[0m]，默认为1:")" checknet
		[[ -z $checknet ]] && mode="1"
		case $checknet in
		1)
			checknet=1;;
		2)
			checknet=2;;
		3)
			checknet=3;;
		*)
			checknet=0
			echo
			echo -e '\e[91m输入错误，请重新输入\e[0m'
			;;
		esac
	done

if [ $checknet -le 2 ]; then   #写入防掉线脚本
	wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/checkwan.sh -O /bin/checkwan.sh
	chmod +x /bin/checkwan.sh
	if [ $checknet -eq 1 ]; then   #写入防掉线脚本并凌晨四点重启网络（开机启动）
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/restartnetwork.sh -O /bin/restartnetwork.sh
		chmod +x /bin/restartnetwork.sh
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/check2  -O /etc/init.d/check
	else
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/check  -O /etc/init.d/check
	fi
	chmod 777 /etc/init.d/check
	ln -s /etc/init.d/check /etc/rc.d/S95check
fi
