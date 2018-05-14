#!/usr/bin/env python
import os
import json
t=os.popen(""" ps -ef | grep redis-server | grep -v grep | awk  '{print $NF}' | awk -F: '{print $2}' """)
ports = []
for port in  t.readlines():
        r = os.path.basename(port.strip())
        ports += [{'{#REDISPORT}':r}]
print json.dumps({'data':ports},sort_keys=True,indent=4,separators=(',',':'))
