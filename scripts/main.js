((config, instance) => 
  pipy({
    _g: {
      _terminated: false,
    },
  })
  
  // discovery: convert real ip to 127.x.x.x and offset port by 10
  .listen(8771)
    .demuxHTTP('request')
  
  .pipeline('request')
    .use([
      'plugins/log.js',
      'plugins/proxy.js',
    ],
      'request',
      'response',
    )
  
  // for pod preStop hook  
  .listen(8762)
    .use(
      'plugins/registry.js',
      'terminating'
    )
  
  //inbound listener
  .listen(+instance?.spec.containers[0]?.ports[0]?.containerPort + 10)
    //simple proxy
    .connect(`127.0.0.1:${+instance?.spec.containers[0]?.ports[0]?.containerPort}`)

  //outbound listener
  .listen(config?.ports?.outbound || 8081) //?
)(
  JSON.decode(pipy.load('config/main.json')),
  JSON.decode(pipy.load('config/pod.json'))
)