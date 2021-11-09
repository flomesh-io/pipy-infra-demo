((eureka, instance) =>
  pipy({
    _router: new algo.URLRouter({
      '/eureka/apps/*': eureka.host,
      '/actuator/*': `127.0.0.1:${+instance?.spec.containers[0]?.ports[0]?.containerPort}`,
    }),
    _target: null
  })
  
  .pipeline('request')
    .handleMessageStart(
      msg => _target = _router.find(
          msg.head.headers.host,
          msg.head.path
        )
    )
    .link(
      'forward', () => Boolean(_target),
      ''
      )
  
  .pipeline('forward')
    .muxHTTP('connection', () => () => _target)
    
  .pipeline('connection')
    .connect(
      () => (
        console.log(`connecting to ${_target}`),
        _target
      )
    )
    // .dump()
  
  .pipeline('response')    
)(
  JSON.decode(pipy.load('config/eureka.json')),
  JSON.decode(pipy.load('config/pod.json')),
  )