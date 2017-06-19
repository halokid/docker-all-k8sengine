package docker1_4_src_book_pratice

import (
  "io"
  "sync"
  "os"
  "github.com/prometheus/common/log"
  "github.com/miekg/dns"
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


repositories, err := graph.NewTagStore(path.Join(config.Root, "repositories" + driver.String), g)


type TagStore struct {
  path                string
  graph               *Grath
  Repositories        map[string]Respository
  sync.Mutex
  pullingPool         map[string]chan struct{}
  pullshingPool       map[string]chan strcut{}
}



if !config.DisableNetwork {
  job := eng.Job("init_networkdriver")

  job.SetenvBool("xxxx", config.EnableIptables)
  //.....

  if err := job.Run(); err != nil {
    return nil, err
  }
}


daemon := &Daemon {
  repository:               daemonRepo,
  containers:               &contStore {s: make(map[string]*Container)},
  graph:                    g,
  repositories:             repositories,
  idIndex:                  truncindex.NewTruncIndex([]string{}),
  sysInfo:                  sysInfo,
  volumns:                  volumns,
  config:                   config,
  driver:                   driver,
  sysInitPath:              sysInitPath,
  execDriver:               ed,
  eng:                      eng,
}



eng.OnShutdown(func() {
  if err := daemon.shutdown(); err != nil {
    //....
  }
  if err := portallocator.ReleaseAll(); err != nil {
    //...
  }
  if err := daemon.driver.Cleanup(); err != nil {
    //...
  }
  if err := daemon.containerGraph.Close(); err != nil {
    //...
  }
})



func ServerApi(job *engine.Job) engine.Status {
  if len(job.Args) == 0 {
    //...
  }
  var (
    protoAddrs = job.Args
    chErrors = make(chan error, len(protoAddrs))    // create chan type is error
    activaionLock = make(chan struct{})
  )

  for _, protoAddrs := range protoAddrs {
    protoAddrParts := strings.SplitN(protoAddrs, "://", 2)
    if len(protoAddrParts) !=  {
      //...
    }

    go func() {     //groutine handle
     log.Info(".....")
      chErrors <- ListenAndServe(protoAddrParts[0], protoAddrParts[1], job)
    } ()
  }

  for i := 0; i < len(protoAddrs); i += 1 {
    err := <-chErrors
    if err != nil {
      return job.Error(err)
    }
  }

  return  engine.StatusOK

}


m := map[string]map[string]HttpApiFunc {
  "GET": {
    "/events":        getEvents,
    "/info":          getInfo,
    "/version":       getVersion,
  },

  "POST": {

  }
}



for method, routes := range m {
  for route, fct := range routes {
    log.Debugf(".....")
    localRoute := route
    localFct := fct
    localMethod := method

    f := makeHttpHandler(eng, logging, localMethod, localRoute, localFct,
                          enableCors, version.Version(dockerVersion))

    if localRoute == "" {
      r.Methods(localMethod).HandlerFunc(f)
    } else {
      r.Path("")
    }
  }
}









































































































