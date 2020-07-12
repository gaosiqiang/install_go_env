# Go环境安装脚本

## 系统要求

本脚本只能应用于Unix系系统的go环境安装

## 结构

install_go.sh是入口脚本

check_go.sh是测试go环境是否安装成功，安装成功输出Hello Word

## 使用

首先先clone下脚本

	git@github.com:gaosiqiang/install_go_env.git

cd到脚本目录

	./install_go.sh

生效

	source ~/.bashrc

使之环境变量生效

脚本安装成功后会输出

	安装成功
	部署测试代码
	hello, world

## 后记

- 如果脚本使用的远程下载链接太慢或者想要下载指定版本可以修改脚本中`go_url`变量指定速度较快或指定版本的url
- 执行安装脚本后成功安装，如果不执行`source ~/.bashrc`，那么go的环境变量没有生效，因为shell脚本中的环境变量只能作用域在shell脚本内，所以需要用全局root权限执行一次才能生效，或者安装成功后直接重启也就不需要执行生效命令了
