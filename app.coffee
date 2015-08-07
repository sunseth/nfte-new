path = require 'path'

express = require 'express'
config = require './config'

app = express()

app.set('service', path.basename __dirname)

require('./middleware/index')(app)
require('./passport')(app)
require('./routes')(app)
require('./middleware/error')(app)

app.listen config.home.port, ->
  console.log "AAA running on port #{config.home.port}"
