path = require 'path'

express = require 'express'

config = require './config'
paths = require './paths'
auth = require './auth'

app = express()

app.set('service', path.basename __dirname)

dependencies = {config, paths, auth}

require('./auth')(app, dependencies)
require('./middleware')(app, dependencies)
require('./routes')(app, dependencies)
require('./data')(app, dependencies)

app.listen config.home.port, ->
  console.log "AAA running on port #{config.home.port}"
