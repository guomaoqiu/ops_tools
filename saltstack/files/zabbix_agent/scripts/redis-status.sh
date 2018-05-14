#!/bin/bash
#REDISCLI="/usr/bin/redis-cli"
#HOST=`ifconfig | grep -A 1 eth0 | grep "inet addr" | awk '{print $2}' | awk -F ':' '{print $2}'`
#HOST='0.0.0.0'
#METRIC="$1"
#PORT="${2}"
#CACHE_FILE="/tmp/redistemp/redis_$PORT.cache"
#[ -d /tmp/redistemp ] || mkdir /tmp/redistemp

#(echo -en "INFO\r\n"; sleep 3;) | nc $HOST $PORT > $CACHE_FILE 2>/dev/null || exit 1

#grep "^$METRIC:" $CACHE_FILE |awk -F':|,' '{print $2}'|sed "s/[^0-9]//g"

#${REDISCLI} -h ${HOST} -p ${PORT} info > ${CACHE_FILE} 2>/dev/null || exit 1
#awk -F'[:,]+' '/'"${METRIC}"':/{gsub(/^[^0-9]+/,"",$2);print $2}' ${CACHE_FILE}

REDISCLI="/usr/bin/redis-cli"
HOST=`ifconfig | grep -A 1 eth0 | grep "inet addr" | awk '{print $2}' | awk -F ':' '{print $2}'`
#HOST=0.0.0.0
PORT="$2"
    case $1 in
        connected_clients)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "connected_clients" | awk -F':' '{print $2}'`
            echo $result
        ;;
        blocked_clients)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "blocked_clients" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_memory)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_memory" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_memory_rss)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_memory_rss" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_memory_peak)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_memory_peak" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_memory_lua)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_memory_lua" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_cpu_sys)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_cpu_sys" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_cpu_user)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_cpu_user" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_cpu_sys_children)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_cpu_sys_children" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_cpu_user_children)
            result=`$REDISCLI -h $HOST -p $PORT info | grep -w "used_cpu_user_children" | awk -F':' '{print $2}'`
            echo $result
        ;;
        rdb_last_bgsave_status)
            result=`$REDISCLI -h $HOST -p $PORT info  | grep -w "rdb_last_bgsave_status" | awk -F':' '{print $2}' | grep -c ok`
            echo $result
        ;;
        aof_last_bgrewrite_status)
            result=`$REDISCLI -h $HOST -p $PORT info  | grep -w "aof_last_bgrewrite_status" | awk -F':' '{print $2}' | grep -c ok`
            echo $result
        ;;
        aof_last_write_status)
            result=`$REDISCLI -h $HOST -p $PORT info  | grep -w "aof_last_write_status" | awk -F':' '{print $2}' | grep -c ok`
            echo $result
        ;;
        *)
    esac
