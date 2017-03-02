#构建开发环境的相关命令


下载镜像及构建

```
make dl
make build

Makefile 里面有一些额外的命令，自己查看
```


构建及运行环境

```
docker-compose build
docker-compose up
```


绑定域名

```
sudo vi /etc/hosts
加入
192.168.0.29 r domain.dev
```


