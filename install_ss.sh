wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log


wget –no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
chmod +x bbr.sh
./bbr.sh

yum install -y vim net-tools epel-release iftop htop

ps aux | grep ssserver | grep -v grep
netstat -anplt

# 重启后检查
uname -r

#输入命令，查看是否有内核4.9.0内核，有就说明更换内核了。

#或者输入这个：

sysctl net.ipv4.tcp_available_congestion_control

#输入命令，然后看是否有返回”net.ipv4.tcp_available_congestion_control = bbr cubic reno”

#输入：

if [ `lsmod | grep bbr | echo $?` -eq 0 ];then
	echo "bbr mod is ok....."
fi
