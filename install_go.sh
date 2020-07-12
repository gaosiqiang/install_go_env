#!/bin/bash

# 初始化
# 脚本所在绝对路径
base_path=$(cd "$(dirname "$0")";pwd);
go_url='https://golang.org/dl/go1.14.4.linux-amd64.tar.gz';

# 函数引用，即引用其他脚本
source ./check_go.sh

# 获取go版本字符串
gv=$(go version);

# check是否安装了go环境，如果按照了直接goto到代码测试环节
## 正则验证方式
gv_reg='^go version+[0-9.a-z/\s]+[0-9a-z/]$';
# if [[ "$gv" =~ $gv_reg ]];then

## 子字符串验证方式
check_gv_str='go version go' # 验证字符串
c_gv=${gv:0:13} # go版本字符串截取子字符串
if [[ "$c_gv" == "$check_gv_str" ]];then
	echo '已安装';
	funCheckGo;
	exit 1;
fi

# 检测是否有安装包，有可能脚本文件夹下有很多文件所以要正则匹配是否有安装包文件
reg='^go+[a-zA-Z0-9_-.*]{0,20}$+.tar.gz';

check_files=$(ls $base_path/*.tar.gz 2> /dev/null | wc -l);
# go_install_packages=$(ls $base_path/go.*.tar.gz 2> /dev/null | wc -l); 

if [ "$check_files" != "0" ] ;then  #如果存在文件
	# 获取文件夹下所有tar.gz包文件
	path_files=$(ls $base_path | grep '.tar.gz');
	# 遍历文件名，正则匹配找出安装包
	for go_file in $path_files
	do
		if [[ "$go_file" =~ $reg ]];then
            break;
        fi
	done
	# 检测出文件:xxx，SHA256:xxxxx。是否安装？Y/N
else
	# 设置下载url？：。如果不设置使用默认url和包名
	# 下载:url，包名：xxxx，SHA256:xxxxx。是否下载？Y/N
	# 下载安装包，如果本地有安装包直接mv到安装目录
	yum -y install wget;
	wget ${go_url};
	go_file='go1.14.4.linux-amd64.tar.gz';
fi

# 提示安装包名
echo '安装包';
echo ${go_file};

# 验证是否安装gcc，如果没有即安装gcc
yum -y install gcc;

# 创建安装目录
cd /usr/local
rm -rf go
mkdir go
cd go
go_path='/usr/local/go';

# 回到脚本目录mv安装包
cd $base_path;
mv ${go_file} $go_path

# 再cd到安装目录
cd $go_path;

# 解压安装包
tar -C /usr/local -xzf ${go_file}
# 将安装包mv到原来的位置
mv ${go_file} $base_path

# 检查是否存在环境变量
str=$(grep  'export PATH=$PATH:/usr/local/go/bin' ~/.bashrc)
str_len=${#str};
if [ "$str_len" == "0" ];then
	# 不存在，设置环境变量，改写~/.bashrc文件
	sed -i '/^# Source global definitions/i export PATH=$PATH:/usr/local/go/bin' ~/.bashrc
fi

# 环境变量生效
source ~/.bashrc
echo '环境变量:' $PATH
cd $base_path;
echo '脚本路径:' $(pwd);

# 获取安装后go版本字符串
installed_gv=$(go version);
echo 'go版本:' $installed_gv;

# 验证是否安装go

## 执行验证方式
# if ![ -x "$(go version)" ]; then
#     echo '安装失败！';
# else
#     echo '安装成功！';
#     # 调用测试函数
# 	funCheckGo;
# fi



## 正则验证方式
# if [[ "$installed_gv" =~ $gv_reg ]]; then
# 	echo '安装成功';
# 	# funCheckGo;
# else
# 	echo '安装失败';
# fi

## 子字符串验证方式
if [[ "${installed_gv:0:13}" == "$check_gv_str" ]];then
	echo '安装成功';
	funCheckGo;
	exit 1;
fi

# 脚本退出，PS:退出exit的参数必须是数字
exit 1;