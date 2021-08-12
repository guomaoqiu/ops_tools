import os
import oss2
import json
import sys
import logging
path = os.path.split(sys.argv[0])[0]
print(path)

endpoint = ""
access_key_id = ""
access_key_secret=""



with open(os.path.join(path,"config.json"), "r", encoding='utf-8') as f:  # 打开文件
    data = f.read()
    data = json.loads(data)
    endpoint = endpoint
    auth = oss2.Auth(access_key_id, access_key_secret)
    bucket = oss2.Bucket(auth, endpoint, "webfile-srv-jj-cn")


def upload_oss_dir(path_way, local_dir, target_dir):
    # 上传整个目录
    root_dir = os.getcwd()
    os.chdir(path_way)
    if os.path.isdir(local_dir):
        file_num = 0
        for root, dirs, files in os.walk(local_dir):
            for index in files:
                file_num += 1
                fileway = root.replace("\\", "/") + "/"
                index = index.replace("\\", "/")
                with open(fileway+index, 'rb') as fileobj:
                    # Seek方法用于指定从第1000个字节位置开始读写。上传时会从您指定的第1000个字节位置开始上传，直到文件结束。
                    fileobj.seek(0, os.SEEK_SET)
                    # Tell方法用于返回当前位置。
                    current = fileobj.tell()
                    bucket.put_object(target_dir+fileway+index, fileobj)
        os.chdir(root_dir)
        return file_num

    else:
        os.chdir(root_dir)
        return False


def upload_oss_file(path_way, local_file, target_dir):
    # 上传单个文件，指定路径，文件名，目标路径
    root = os.getcwd()
    os.chdir(path_way)
    if os.path.isfile(local_file):
        with open(local_file, 'rb') as fileobj:
            # Seek方法用于指定从第1000个字节位置开始读写。上传时会从您指定的第1000个字节位置开始上传，直到文件结束。
            fileobj.seek(0, os.SEEK_SET)
            # Tell方法用于返回当前位置。
            current = fileobj.tell()
            bucket.put_object(target_dir+local_file, fileobj)
    else:
        os.chdir(root)
        return False
    os.chdir(root)


def delete_oss_dir(target_dir):
    # target_dir需要在末尾添加 /
    for obj in oss2.ObjectIterator(bucket, prefix=target_dir):
        bucket.delete_object(obj.key)


def delete_oss_file(target_file):
    bucket.delete_object(target_file)
