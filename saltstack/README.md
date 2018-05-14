

##### 1.zabbix agent批量安装
```
salt_for_zabbix_agent_install.tar.gz
```
解压到/srv/salt/目录；
执行 salt "*" state.sls zabbix_agent 即可

------


