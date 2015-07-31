config = require './config'
paths = require './paths'

passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
FacebookStrategy = require('passport-facebook').Strategy
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy

module.exports = (app) ->

  passport.use(new LocalStrategy (username, password, done) ->

  )

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
    return done null, user

  passport.deserializeUser (user, done) ->
    return done null, user