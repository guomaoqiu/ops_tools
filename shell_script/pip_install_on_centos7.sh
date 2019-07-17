# 用于centos安装pip组件
yum install epel-release -y
yum install python-pip python-devel -y
yum groupinstall 'development tools' -y
pip install requests
