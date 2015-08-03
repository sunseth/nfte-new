config = require './config'
paths = require './paths'
{User} = require './data'

passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
FacebookStrategy = require('passport-facebook').Strategy
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy

module.exports = (app) ->

  passport.use(new LocalStrategy({
      usernameField: 'email'
    }, (email, password, done) ->
    User.findOne({email}).exec (err, user) ->
      return done(err) if err
      return done(null, false) unless user
      return done(null, false) unless user.authenticate(password)
      return done(null, user)
  ))

  # passport.use 'FacebookLogin', new FacebookStrategy(
  #   clientId: config.facebook.clientId
  #   clientSecret: config.facebook.clientSecret
  #   callbackURL: paths.public.home.index
  # , () ->
  # )

  # passport.use 'GoogleLogin', new GoogleStrategy(
  #   clientID: config.google.clientId
  #   clientSecret: config.google.clientSecret
  #   callbackURL: paths.public.home.index
  # , () ->
  # )

  passport.serializeUser (user, done) ->
    return done null, user._id

  passport.deserializeUser (id, done) ->
    User.findById(id).exec done

  app.use passport.initialize()
  app.use passport.session()