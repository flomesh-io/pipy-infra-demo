pipy({
    _buffer: [],
})

.task('5s')
  //fetch merics

.task('30s')
  .replaceMessage(
    new Message(
      {
        
      },
      {}
    )
  )
  .connect('http://clickhouse:8123')