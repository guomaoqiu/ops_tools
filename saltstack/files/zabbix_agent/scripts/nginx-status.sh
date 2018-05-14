#!/bin/bash
case $1 in 
  status)
  #检测nginx进程个数
  Pro=`/sbin/pidof nginx | wc -l`

  #检测nginx端口个数
  Port=`ss -tunl | grep -c :80`

  #进行判断
  if [ "$Pro" -eq 0 -o "$Port" -eq 0 ];then
    #如果两个条件满足一条说明nginx未启动
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
