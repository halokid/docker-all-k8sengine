package rcli

// rcli (Remote Command-Line Interface) is a simple protocol for...
// serving command-line interfaces remotely.
//
// rcli can be used over any transport capable of a) sending binary streams in
// both directions, and b) capable of half-closing a connection. TCP and Unix sockets
// are the usual suspects.

import (
	"errors"
	"flag"
	"fmt"
	"io"
	"log"
	"reflect"
	"strings"
)

type Service interface {
	Name() string
	Help() string
}

type Cmd func(io.ReadCloser, io.Writer, ...string) error
type CmdMethod func(Service, io.ReadCloser, io.Writer, ...string) error

/**
docker 服务端接收到  docker 客户端的请求之后，真正执行逻辑的函数
 */
func call(service Service, stdin io.ReadCloser, stdout io.Writer, args ...string) error {
	if len(args) == 0 {
		args = []string{"help"}
	}
	flags := flag.NewFlagSet("main", flag.ContinueOnError)
	flags.SetOutput(stdout)
	flags.Usage = func() { stdout.Write([]byte(service.Help())) }
	if err := flags.Parse(args); err != nil {
		return err
	}
	cmd := flags.Arg(0)
	log.Printf("%s\n", strings.Join(append(append([]string{service.Name()}, cmd), flags.Args()[1:]...), " "))
	if cmd == "" {
		cmd = "help"
	}
	// 上面为解释 docker help命令后面的参数的， 下面为根据参数的不同，而执行不同的 method，可以认为是一种handler吧
	method := getMethod(service, cmd)				// 执行method
	if method != nil {
		return method(stdin, stdout, flags.Args()[1:]...)			// 如果 method 不为空， 则执行 method
	}
	return errors.New("No such command: " + cmd)
}

func getMethod(service Service, name string) Cmd {
	// 如果参数为 help
	if name == "help" {
		return func(stdin io.ReadCloser, stdout io.Writer, args ...string) error {
			if len(args) == 0 {
				stdout.Write([]byte(service.Help()))
			} else {
				if method := getMethod(service, args[0]); method == nil {
					return errors.New("No such command: " + args[0])
				} else {
					method(stdin, stdout, "--help")
				}
			}
			return nil
		}
	}

	// 如果参数不为 help
	methodName := "Cmd" + strings.ToUpper(name[:1]) + strings.ToLower(name[1:])
	method, exists := reflect.TypeOf(service).MethodByName(methodName)		// golang 的 reflect 机制获取方法的名字
	if !exists {
		return nil
	}

	// FIXME: 真正执行 docker 命令行逻辑的代码段
	return func(stdin io.ReadCloser, stdout io.Writer, args ...string) error {

		// 这里就是 具体执行docker 客户端发过来的命令的逻辑代码， 是利用 golang的 reflect 机制来执行呃
		ret := method.Func.CallSlice([]reflect.Value{
			reflect.ValueOf(service),
			reflect.ValueOf(stdin),
			reflect.ValueOf(stdout),
			reflect.ValueOf(args),
		})[0].Interface()
		if ret == nil {
			return nil
		}
		return ret.(error)
	}
}

func Subcmd(output io.Writer, name, signature, description string) *flag.FlagSet {
	flags := flag.NewFlagSet(name, flag.ContinueOnError)
	flags.SetOutput(output)
	flags.Usage = func() {
		fmt.Fprintf(output, "\nUsage: docker %s %s\n\n%s\n\n", name, signature, description)
		flags.PrintDefaults()
	}
	return flags
}
