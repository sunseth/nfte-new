path = require 'path'

express = require 'express'
config = require './config'

app = express()


app.set('service', path.basename __dirname)

require('./middleware/index')(app)
require('./passport')(app)
require('./routes')(app)
require('./middleware/error')(app)

io = require('socket.io').listen(app.listen config.home.port, ->
  console.log "AAA running on port #{config.home.port}")

io.on 'connection', (socket) ->
  console.log 'connection'
  socket.emit 'news', hello: 'world'
  socket.join('lobby')

  socket.on 'message', (data) ->
  	console.log data.email, data.msg, data.name
  	emitObj = 
  	  email: data.email
  	  msg: data.msg
  	  name: data.name
  	socket.broadcast.to('lobby').emit(data.email, emitObj)
  	#socket.emit 'news', hello: 'world'
  	#socket.emit data.email, data.msg
  return