#!/usr/bin/python
#-*- coding:utf8 -*-
from aliyunsdkecs.request.v20140526 import DescribeInstancesRequest,ModifyInstanceAttributeRequest
import json
from aliyunsdkcore.client import AcsClient

ACCESS_KEY = "aliyunKEY"
ACCESS_SECRET_KEY = "aliyun加密key"

client = AcsClient(ACCESS_KEY, ACCESS_SECRET_KEY, 'cn-hangzhou')


def get_ecs_info(client):
    data = []
    PageNumber = 1

    request = DescribeInstancesRequest.DescribeInstancesRequest()
    request.set_accept_format('json')
    request.set_PageSize(100)
    request.set_PageNumber(PageNumber)
    result = client.do_action(request)

    r = json.loads(result)['Instances']['Instance']

    for i in r:
        name = i["InstanceName"]
        instance_id = i["InstanceId"]
        ip = i['InnerIpAddress']['IpAddress'][0]
	#print ip
	#if "i-bp18yfs6" in name:
        if len(name) == 23:
            data.append(instance_id)
    return data


#
def set_instance_name(instance_id, name):
    #return instance_id, name
    request = ModifyInstanceAttributeRequest.ModifyInstanceAttributeRequest()
    request.set_accept_format("json")
    request.set_InstanceId(instance_id)
    request.set_InstanceName(name)
    result = client.do_action(request)
    r = json.loads(result)

    print "实例ID: ",instance_id, "实例名称: ",name, "请求ID: ",r



def check_result(client,numbers):
    data = []
    PageNumber = 1
    request = DescribeInstancesRequest.DescribeInstancesRequest()
    request.set_accept_format('json')
    request.set_PageSize(numbers)
    request.set_PageNumber(PageNumber)
    result = client.do_action(request)
    r = json.loads(result)['Instances']['Instance']

    print "修改结果为:"

    with open("./new_server", 'w') as file:
        for i in r:
	    #print r
            name = i["InstanceName"]
            #instance_id = i["InstanceId"]
            ip = i['InnerIpAddress']['IpAddress'][0]

            #print ip, name

            file.writelines(ip + "   " + name+"\n")

if __name__ == "__main__":
    ios_list = [ ("shipgs-3-") + str(ios) for ios in range(6,18)]
    and_list =  [ ("shipgs-2-") + str(And) for And in range(8,24)]
    [ and_list.append(ios_name) for ios_name in ios_list ]

    if len(and_list) == len(get_ecs_info(client)):
        print "新添加数量:",len(get_ecs_info(client))
        print "欲修改主机名个数: ios:%s, and:%s" % (len(ios_list),len(and_list) - len(ios_list))
    #
        info=dict(zip(and_list, get_ecs_info(client)))
    
        #for server_name,server_id in  info.items():
            #print server_name,server_id
            #set_instance_name(instance_id=server_id,name=server_name)

    check_result(client,numbers=len(and_list))
    print 'Done~~~~~~共计：%s 台servername修改~~~~~~~' % len(and_list)
    print "可执行 sh /root/tools/add_new_server_list.sh 添加主机"
