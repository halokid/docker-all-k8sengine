package docker0_1_coreCode

import (
  "os/exec"
  "os"
)

func (container *Container) Start() error {
  if err := container.EnsureMounted(); err != nil {
    return err
  }

  if err := container.allocateNetwork(); err != nil {
    return err
  }

  if err := container.generateLXConfig(); err != nil {
    return err
  }

  //省略
  //为cmd赋值
  container.cmd = exec.Command("/usr/bin/lxc-start", params...)
  //省略
  if container.Config.Try {
    err = container.startPty()
  } else {
    //启动
    err = container.start()
  }

  //省略
  go container.monitor()
  return nil
}


func (container *Container) start() error {
  //配置一些环境
  return container.cmd.Start()
}


func (c *Cmd) Start() error {
  //配置Cmd struct 的其他参数， Cmd封装了 "/usr/bin/lxc-start"所需的所有参数，
  // os.StartProcess 执行它
  c.Process, err = os.StartProcess(c.Path, c.argv(), &os.ProcAttr{
    Dir:    c.Dir,
    Files:  c.childFiles,
    Env:    c.envv(),
    Sys:    c.SysProAttr,
  })

  //其他后续工作
}














