/**
docker 的客户端代码
 */

package main

import (
	"../client"
	"flag"
	"log"
	"os"
	"path"
)

func main() {
	if cmd := path.Base(os.Args[0]); cmd == "docker" {
		//检查是否有 -i 参数
		fl_shell := flag.Bool("i", false, "Interactive mode")
		flag.Parse()
		if *fl_shell {
			// 如果有 -i 则是交互模式启动容器
			if err := client.InteractiveMode(flag.Args()...); err != nil {
				log.Fatal(err)
			}
		} else {
			// 没有 -i 就是一般的模式启动容器
			if err := client.SimpleMode(os.Args[1:]); err != nil {
				log.Fatal(err)
			}
		}
	} else {
		if err := client.SimpleMode(append([]string{cmd}, os.Args[1:]...)); err != nil {
			log.Fatal(err)
		}
	}
}
