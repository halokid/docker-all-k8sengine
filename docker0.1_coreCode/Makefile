GOPATH := $(PWD)/env
BUILDPATH := $(PWD)/build

all: docker.o dockerd.o

env:
	mkdir -p ${BUILDPATH} ${GOPATH}/src/github.com/dotcloud/
	ln -s $(PWD) ${GOPATH}/src/github.com/dotcloud/docker

deps:
	GOPATH=${GOPATH} go get github.com/kr/pty
	GOPATH=${GOPATH} go get github.com/mattn/go-sqlite3
	GOPATH=${GOPATH} go get github.com/shykes/gorp

clean:
	go clean
	rm -rf env build


# 编译docker客户端的命令， 编译的入口文件是 ./docker/docker.go
docker.o: env deps
	GOPATH=${GOPATH} go build -o ${BUILDPATH}/docker docker/docker.go


# 编译docker服务端的命令， 编译的入口文件是 ./dockerd/dockerd.go
dockerd.o: env deps
	GOPATH=${GOPATH} go build -o ${BUILDPATH}/dockerd dockerd/dockerd.go





