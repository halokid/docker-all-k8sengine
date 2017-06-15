package main

import (
  "fmt"
  "reflect"
)

/**
import (
  "fmt"
  "time"
)

func goFunc1(f func()) {
  go f()
}


func goFunc2(f func(interface{}), i interface{}) {
  go f(i)
}

func goFunc(f interface{}, args... interface{}) {
  if len(args) > 1 {
    go f.(func(...interface{}))(args)
  } else if len(args) == 1 {
    go f.(func(interface{}))(args[0])
  } else {
    go f.(func())()
  }
}


func f1() {
  fmt.Println("f1 done")
}


func f2(i interface{}) {
  fmt.Println("f2 done", i)
}

func f3(args ...interface{}) {
  fmt.Println("f3 done", args)
}


func main() {

  fmt.Println("start....")
  goFunc1(f1)
  goFunc2(f2, 100)

  goFunc(f1)
  goFunc(f2, "xxx")
  goFunc(f3, "hello", "world", 1, 2, 3)
  time.Sleep(5 * time.Second)
}

**/


func someFunction1(a, b int) int {
  return a + b
}

func someFunction2(a, b int) int {
  return a - b
}


func someOtherFunction(a, b int, f func(int, int) int) int {
  return f(a, b)
}


func foo() {
  fmt.Println("foo func")
}

func bar(a, b int) {
  c := a + b
  fmt.Println(c)
}



func Call(m map[string]interface{}, name string, params ... interface{}) (result []reflect.Value, err error) {
    f = reflect.ValueOf(m[name])
}

func main() {
  fmt.Println(someOtherFunction(111, 12, someFunction1))
  fmt.Println(someOtherFunction(111, 12, someFunction2))

  m := map[string]func(int, int) int {
    "someFunction1" : someFunction1,
    "someFunction2" : someFunction2,
  }

  x := 111
  y := 12
  z1 := someOtherFunction(x, y, m["someFunction1"])
  fmt.Println(z1)
  z2 := someOtherFunction(x, y, m["someFunction2"])
  fmt.Println(z2)


}



















