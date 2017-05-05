package client

import (
	"../future"
	"../rcli"
	"io"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path"
	"path/filepath"
)

// Run docker in "simple mode": run a single command and return.
// 处理一般模式运行 docker 容器的程序
func SimpleMode(args []string) error {
	var oldState *State
	var err error
	if IsTerminal(0) && os.Getenv("NORAW") == "" {
		oldState, err = MakeRaw(0)
		if err != nil {
			return err
		}
		defer Restore(0, oldState)
	}
	// FIXME: we want to use unix sockets here, but net.UnixConn doesn't expose
	// CloseWrite(), which we need to cleanly signal that stdin is closed without
	// closing the connection.
	// See http://code.google.com/p/go/issues/detail?id=3345

	// 如果不是交互模式运行容器， 则是跟本地的 dockerd 通信， 然后通过 dockerd 来执行


	// FIXME: 那么我们弄清楚了 docker容器启动的两种模式，这两种模式主要都是 linux命令的执行和系统变量的一些设定程序
	// FIXME: 那下一步我们应该看  docker服务端 收到 docker客户端 发来的命令之后的执行流程代码了
	conn, err := rcli.Call("tcp", "127.0.0.1:4242", args...)
	if err != nil {
		return err
	}
	receive_stdout := future.Go(func() error {
		_, err := io.Copy(os.Stdout, conn)
		return err
	})
	send_stdin := future.Go(func() error {
		_, err := io.Copy(conn, os.Stdin)
		if err := conn.CloseWrite(); err != nil {
			log.Printf("Couldn't send EOF: " + err.Error())
		}
		return err
	})
	if err := <-receive_stdout; err != nil {
		return err
	}
	if oldState != nil {
		Restore(0, oldState)
	}
	if !IsTerminal(0) {
		if err := <-send_stdin; err != nil {
			return err
		}
	}
	return nil
}

// Run docker in "interactive mode": run a bash-compatible shell capable of running docker commands.
// 处理交互模式运行 docker 容器的程序
func InteractiveMode(scripts ...string) error {
	// Determine path of current docker binary
	dockerPath, err := exec.LookPath(os.Args[0])
	if err != nil {
		return err
	}
	dockerPath, err = filepath.Abs(dockerPath)
	if err != nil {
		return err
	}

	// Create a temp directory
	tmp, err := ioutil.TempDir("", "docker-shell")
	if err != nil {
		return err
	}
	defer os.RemoveAll(tmp)

	// For each command, create an alias in temp directory
	// FIXME: generate this list dynamically with introspection of some sort
	// It might make sense to merge docker and dockerd to keep that introspection
	// within a single binary.
	for _, cmd := range []string{
		"help",
		"run",
		"ps",
		"pull",
		"put",
		"rm",
		"kill",
		"wait",
		"stop",
		"start",
		"restart",
		"logs",
		"diff",
		"commit",
		"attach",
		"info",
		"tar",
		"web",
		"images",
		"docker",
	} {
		if err := os.Symlink(dockerPath, path.Join(tmp, cmd)); err != nil {
			return err
		}
	}

	// Run $SHELL with PATH set to temp directory
	// 交互模式的方式是通过  docker-shell-rc 这种交互脚本去执行的
	rcfile, err := ioutil.TempFile("", "docker-shell-rc")
	if err != nil {
		return err
	}
	defer os.Remove(rcfile.Name())
	io.WriteString(rcfile, "enable -n help\n")
	os.Setenv("PATH", tmp+":"+os.Getenv("PATH"))
	os.Setenv("PS1", "\\h docker> ")
	shell := exec.Command("/bin/bash", append([]string{"--rcfile", rcfile.Name()}, scripts...)...)
	shell.Stdin = os.Stdin
	shell.Stdout = os.Stdout
	shell.Stderr = os.Stderr
	if err := shell.Run(); err != nil {
		return err
	}
	return nil
}
