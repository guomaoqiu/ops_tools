用于批量修改阿里云主机名
首先通过该脚本检测新添加主机的id与实际是否相符
```
python change_ecs_name_forguomaoqiu_check_id.py server_list.txt
```
检查通过则执行该脚本修改主机名
```
python change_ecs_name_forguomaoqiu.py server_list.txt
```
注意 server_list.txt 的内容是 IP对应欲修改主机名空格隔开即可






