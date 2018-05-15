

#### 1.zabbix agent批量安装
```
cp -rf zabbix/files zabbix/zabbix_agent.sls /srv/salt/
```
<<<<<<< HEAD
1. 执行 salt "*" state.sls zabbix_agent
2. web页面导入zabbix模板zbx_export_templates.xml
=======
a.执行 salt "*" state.sls zabbix_agent

b.web页面导入zabbix模板zbx_export_templates.xml
>>>>>>> 85942e44a36188b2cd20256017350b0376d6e2b0

------


