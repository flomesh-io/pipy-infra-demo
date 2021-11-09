((config, eureka, instance) => 
  pipy({
    _g: {
      _terminated: false,
    },
  })
  
  // for dumping real instance traffic
  .listen(8771)
    .demuxHTTP('request')
  
  .pipeline('request')
    .use(
      config.plugins,
      'request',
      'response',
    )
  
  // health check
  .task(eureka.client.healthcheckInterval)
    .use(
      config.plugins,
      'healthcheck',
      () => _g._terminated,
    )
    .replaceMessage(new StreamEnd)
  
  // heartbeat
  .task(eureka.client.heartbeatInterval)
    .use(
      config.plugins,
      'heartbeat',
      () => _g._terminated,
    )
    .replaceMessage(new StreamEnd)
  
  // for pod preStop hook  
  .listen(8762)
    .use(
      config.plugins,
      'terminating'
    )
    .replaceMessage(
      msg => (
        msg.head.status == 200 && (
          _g._terminated = true
        ),
        new Message(msg.head, '')
      )
    )
    .encodeHTTPResponse()
  
  //inbound listener
  .listen(+instance?.spec.containers[0]?.ports[0]?.containerPort + 10)
)(
  JSON.decode(pipy.load('config/main.json')),
  JSON.decode(pipy.load('config/eureka.json')),
  JSON.decode(pipy.load('config/pod.json'))
)