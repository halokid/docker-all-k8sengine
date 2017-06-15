package docker1_4_src_book_pratice

import (
  "io"
  "sync"
  "os"
)

type Engine struct {
  handlers        map[string]Handler
  catchall        Handler
  hack            Hack
  id              string
  Stdout          io.Writer
  Stderr          io.Writer
  Stdin           io.Reader
  Logging         bool
  tasks           sync.WaitGroup
  l               sync.RWMutex
  shutdown        bool
  onShutdown      []func()
}

type Handler func(*Job) Status


func (*Engine) New() *Engine {
  eng := &Engine{
      handlers:       make(map[string]Handler),
      id:             utils.RandomString(),
      Stdout:         os.Stdout,
      Stderr:         os.Stderr,
      //.....
  }
}


eng := Engin.New()
eng.Register("commands", func(job *Job) Status{
  for _, name := range eng.commands() {
    job.Printf("-----")
  }
  //....
})


func (eng *Engine) Job(name string, args ...string) *Job {
  job := &Job {
    Eng:        eng,
    Name:       name,
    Args:       args,
    Stdin:      NewInput(),
    Stdout:     NewOutput(),
    env:        &Env{},
  }

  if eng.Logging {
    //....
  }
  if handler, exists := eng.handlers[name]; exists {
    //...
  } else if eng.catchall != nil && name != "" {
    //....
  }
  return job
}




















