#!/bin/bash
EDISCLI="/usr/bin/redis-cli"
HOST=`ifconfig | grep -A 1 eth0 | grep "inet addr" | awk '{print $2}' | awk -F ':' '{print $2}'`
PORT="$2"

case $1 in 
  status)

  ps aux | grep "redis-server $HOST:$2" | grep -v grep>/dev/null
  if [ $? -ne 0 ];then
     echo "1" #如果得到的PONG次数为0则说明redis服务不正常，返回数字1
  else
     echo "0" #反之0代码为正常
  fi
  ;;
esac
