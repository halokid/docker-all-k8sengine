/**
docker 的服务端代码
 */
package main

import (
	".."			// 这里直接就 import 外面那层目录的所有程序文件了
	"../server"
	"flag"
	"log"
)

func main() {
	if docker.SelfPath() == "/sbin/init" {		// 这个函数是在 utils.go， utils.go 开头的 package 是 docker, 所以可以这样用， 其实golang的包和文件是没什么关系的，一切的import是看包和包的路径的
		// Running in init mode
		docker.SysInit()
		return
	}
	flag.Parse()
	d, err := server.New()			//开始进行服务端的服务, d 是一个 Server 的结构体
	if err != nil {
		log.Fatal(err)
	}
	if err := d.ListenAndServe(); err != nil {			//监听端口
		log.Fatal(err)
	}
}
