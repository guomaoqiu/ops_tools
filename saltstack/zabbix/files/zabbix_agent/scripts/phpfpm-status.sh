#!/bin/bash

case $1 in 
  status)
  #检测php-fpm进程个数
  Pro=`/sbin/pidof php-fpm | wc -l`

  #检测php-fpm套接字文件是否存在
  Sock=`[ -e /var/run/php-fpm.sockew ] ; echo $?`

  #进行判断
  if [ "$Pro" -eq 0 -o "$Sock" -eq 0 ];then
    #如果两个条件满足其中一条说明php-fpm未启动
    echo '1'
    #反之
  else
    echo '0'
  fi
  ;;
  *) 
   echo "Error!"
  ;;
esac
