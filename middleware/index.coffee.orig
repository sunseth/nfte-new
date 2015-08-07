compression = require 'compression'
bodyParser = require 'body-parser'
<<<<<<< HEAD
morgan = require 'morgan'
config = require '../config'
multer = require 'multer'
aws = require 'aws-sdk'
=======
cookieParser = require 'cookie-parser'
session = require 'express-session'
RedisStore = require('connect-redis')(session)
flash = require 'connect-flash'
csurf = require 'csurf'
responseTime = require 'response-time'

config = require '../config'
paths = require '../paths'

dependencies = {config, paths}
>>>>>>> master

module.exports = exports = (app) ->
  # Disable express header
  app.disable 'x-powered-by'

  app.set 'json spaces', 2

  app.use compression()

  app.use bodyParser.json()

  app.use bodyParser.urlencoded
    extended: true

  app.use cookieParser()

  app.use session
    store: new RedisStore(
      port: config.redis.port
      host: config.redis.host
      db: config.redis.db
    )
    resave: true,
    saveUninitialized: true
    secret: config.redis.secret
    cookie:
      maxAge: 1000 * 60 * 60 * 24 * 30

  # app.use csurf()

  app.use flash()

  app.use responseTime()

  app.set 'trust proxy', config.middleware.trustProxy

  # ignore static files, assume it has a . somewhere
  app.use morgan 'tiny', {
    skip: (req, res) ->
      return req.originalUrl.indexOf('.') != -1
  }

  # app.multer = multer
  app.use multer(
    limit:
      fieldNameSize: 100
      fieldSize: 5
    dest: './uploads/'
    rename: (fieldname, filename) ->
      filename + Date.now()
    onFileUploadStart: (file) ->
      console.log file.originalname + ' is starting ...'
      return
    onFileUploadComplete: (file) ->
      console.log file.fieldname + ' uploaded to  ' + file.path
      done = true
      return
    onFieldsLimit: ->
      console.log 'Crossed fields limit!'
      return
  )
    
  # app.use multer(dest: './uploadies')
