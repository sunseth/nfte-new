http = require 'http'

bodyParser = require 'body-parser'
morgan = require 'morgan'
config = require '../config'


module.exports = (app) ->
  # Disable express header
  app.disable 'x-powered-by'

  app.set 'json spaces', 2

  app.use bodyParser.json
    limit: 104900000


  app.use bodyParser.urlencoded
    extended: true
    limit: 104900000

  app.use (req, res, next) ->
    res.locals.config = config
    next()

  app.set 'trust proxy', config.middleware.trustProxy

  # ignore static files, assume it has a . somewhere
  app.use morgan 'tiny', {
    skip: (req, res) ->
      return req.originalUrl.indexOf('.') != -1
  }