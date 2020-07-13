#!/bin/sh
checknet=0; 

while [ $checknet -eq 0 ]
	do
		echo
		echo "...........欢迎使用 R2S 防断线脚本.........."
		echo " 防断线脚本是为了处理pppoe模式下网络断连和防火墙崩溃的折中解决方案，若没上述问题，请谨慎刷入"
		echo		
		echo " 1. 写入防掉线脚本并于凌晨4点重启网络（开机自动运行）"
		echo
		echo " 2. 写入防掉线脚本（开机自动运行）"
		echo
		echo " 3. 写入凌晨4点重启网络线脚本（开机自动运行）"
		echo		
		echo " 4. 不写入"
		echo
		read -p "$(echo -e "请选择 [\e[95m1-3\e[0m]，默认为3:")" checknet
		[[ -z $checknet ]] && mode="3"
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
	
echo '检查依赖文件...'
if ! type "nohup" > /dev/null; then
	opkg update ; opkg install coreutils-nohup
	if ! type "nohup" > /dev/null; then
		echo 'nohup安装失败，退出...'
		exit 1
	fi
fi

if [ $checknet -le 3 ]; then   #写入防掉线脚本
	wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/checkwan.sh -O /bin/checkwan.sh
	chmod +x /bin/checkwan.sh
	if [ $checknet -eq 1 ]; then   #写入防掉线脚本并凌晨四点重启网络（开机启动）
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/restartnetwork.sh -O /bin/restartnetwork.sh
		chmod +x /bin/restartnetwork.sh
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/check2  -O /etc/init.d/check
		if `ps | grep restartnetwork.sh |grep /|cut -d % -f2`; then
			sleep 2
			nohup sh /bin/restartnetwork.sh  1>/dev/null 2>&1 &
			echo '检测到网络重启脚本未运行，现已运行脚本'
		else
			echo '网络重启脚本已运行'
		fi
	elif  [ $checknet -eq 3 ]; then   #写入防掉线脚本并凌晨四点重启网络（开机启动）
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/restartnetwork.sh -O /bin/restartnetwork.sh
		chmod +x /bin/restartnetwork.sh
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/check3  -O /etc/init.d/check
		if `ps | grep restartnetwork.sh |grep /|cut -d % -f2`; then
			sleep 2
			nohup sh /bin/restartnetwork.sh  1>/dev/null 2>&1 &
			echo '检测到网络重启脚本未运行，现已运行脚本'
		else
			echo '网络重启脚本已运行'
		fi
	else
		wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/check  -O /etc/init.d/check
	fi
	chmod 777 /etc/init.d/check
	ln -s /etc/init.d/check /etc/rc.d/S95check
	if [ $checknet -le 3 ]; then   #写入防掉线脚本
		if `ps | grep checkwan.sh |grep /|cut -d % -f2`; then
			sleep 1
			nohup sh /bin/checkwan.sh  1>/dev/null 2>&1 &
			echo '检测到防断线脚本未运行，现已运行脚本'
		else
			echo '防断线脚本已运行'
		fi
	fi
fi
