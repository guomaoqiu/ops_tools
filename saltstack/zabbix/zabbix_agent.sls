install_zabbix_agent:
  file.managed:
    - name: /tmp/zabbix-agent-3.0.4-1.el6.x86_64.rpm
    - source: salt://files/zabbix_agent/zabbix-agent-3.0.4-1.el6.x86_64.rpm
  cmd.run:
    - names:
      - rpm -ivh /tmp/zabbix-agent-3.0.4-1.el6.x86_64.rpm
    #- unless: test -e /etc/zabbix/zabbix_agentd.conf

zabbix_agent_file:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://files/zabbix_agent/zabbix_agentd.conf
    - template: jinja
    - defaults:
      # 通过jinja模板来定义zabbix-server的IP
      #ZABBIX_SERVER: 111.111.111.111
      PORT: 10.1.0.167

zabbix_agent_start:
  cmd.run:
    - names:
      - /sbin/chkconfig --add zabbix-agent
      - /sbin/chkconfig zabbix-agent on
  service.running:
    - name: zabbix-agent
    - enable: True
    - restart: True
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf


##############################
# zabbix Custom alertscripts #
##############################
/etc/zabbix/scripts:
  file.recurse:
    - target: /etc/zabbix/scripts
    - source: salt://files/zabbix_agent/scripts
    - user: root
    - group: root
    - file_mode: 755
    - dir_mode: 655
    - makedirs: True
    #- template: jinja
    #- include_empty: True

/etc/zabbix/zabbix_agentd.d:
  file.recurse:
    - target: /etc/zabbix/zabbix_agentd.d
    - source: salt://files/zabbix_agent/zabbix_agentd.d
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 655
    - makedirs: True
#
zabbix_service:
  cmd.run:
    - names:
      - /etc/init.d/zabbix-agent restart 
