express = require 'express'
engine = require 'ejs-locals'
passport = require 'passport'
cookieParser = require 'cookie-parser'

module.exports = (app, dependencies) ->

  app.engine 'ejs', engine
  app.set 'views', "#{__dirname}/../views"
  app.set 'view engine', 'ejs'

  app.use '/', express.static("#{__dirname}/../public")

  app.use passport.initialize()
  app.use passport.session()

  app.use cookieParser()

  require('./home')(app, dependencies)
  require('./events')(app, dependencies)
  require('./families')(app, dependencies)
  require('./committees')(app, dependencies)
  require('./cabinet')(app, dependencies)
  require('./media')(app, dependencies)