path = require 'path'

express = require 'express'
config = require './config'

app = express()

app.set('service', path.basename __dirname)

require('./passport')(app)
require('./middleware')(app)
require('./routes')(app)

app.listen config.home.port, ->
  console.log "AAA running on port #{config.home.port}"
