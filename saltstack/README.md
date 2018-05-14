

#### 1.zabbix agent批量安装
```
cp -rf zabbix/files zabbix/zabbix_agent.sls /srv/salt/
```
a.执行 salt "*" state.sls zabbix_agent
b.web页面导入zabbix模板zbx_export_templates.xml

------


