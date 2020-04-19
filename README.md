脚本说明：
此为R2S在线升级脚本
运行必须有/mnt/mmcblk0p2/的本地目录，否则无法运行。

ssh命令：
在线更新脚本
wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/update.sh -O update.sh && sh ./update.sh

防断线脚本（已包含在更新脚本中，无需重复写入）
wget -nv https://github.com/lsl330/R2S-SCRIPTS/raw/master/checknet.sh -O checknet.sh && sh ./checknet.sh


