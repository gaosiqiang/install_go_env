# 测试函数
funCheckGo(){
	# 部署测试代码，测试安装环境，如果安装成功输出success
	echo '部署测试代码';
	# 创建hello.go文件，然后写入代码
	touch hello.go
	# 赋予文件读写权限
	chmod +rwx hello.go
	# 定义多行字符串变量code
	# read -d '' code <<-"_EOF_"

	# package main
		
	# import "fmt"
		
	# func main() {
	# 	fmt.Printf("hello, world\n")
	# }

	# _EOF_

	# sed -i "1a $code" hello.go

	# 直接将代码写入文件
	cat > hello.go <<_EOF_

		package main
		import "fmt"
		func main() {
		    fmt.Printf("hello, world\n")
		}

_EOF_

	# go run
	# go run hello.go > tmp
	# cat tmp
	echo $(go run hello.go);
	# -f强制删除hello.go文件
	rm -f hello.go
}