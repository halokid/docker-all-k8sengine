package docker0_1_coreCode

import (
  "net"
  "log"
  "fmt"
)

func ListenAndServe(proto, addr string, service Service) error {
  listener, err := net.Listen(proto, addr)
  defer listener.Close()

  //for循环监听连接， 开启新的“线程”处理连接
  for {
    if conn, err := listener.Accept(); err != nil {
      return err
    } else {
      //使用GoRoutine执行一个匿名函数处理连接
      go func() {
        if err := Serve(conn, service); err != nil {
          log.Printf("Error: " + err.Error() + "\n")
          fmt.Println(conn, "Error: " + err.Error() + "\n")
        }
       conn.Close()
      } ()
    }
  }
  return nil
}



