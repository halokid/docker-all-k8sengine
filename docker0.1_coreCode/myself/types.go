package docker0_1_coreCode

import (
  "io"
  "errors"
  "os/exec"
  "strings"
  "reflect"
)

func LocalCall(service Service, stdin io.ReadCloser, stdout io.Writer, args ...string) error {
  method := getMethod(service, cmd)
  if method != nil {
    return method(stdin, stdout, flags.Args()[1:]...)
  }
  return errors.New("No such command: " + cmd)
}

func getMethod(service Service, name string) Cmd {
  methodName := "Cmd" + strings.ToUpper(name[1:]) + strings.ToLower(name[1:])
  method, exists := reflect.TypeOf(srevice).MethodByName(methodName)
  if !exists {
    return nil
  }
  //这个待理解
  return func(stdin io.ReadCloser, stdout io.Writer, args ...string) error {
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










