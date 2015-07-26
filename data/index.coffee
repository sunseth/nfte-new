mongoose = require 'mongoose'
config = require '../config'

mongoose.connect config.mongo.uri, config.mongo.options
mongoose.connection.on 'error', (err) ->
  console.error config.mongo
  throw new Error(err) if err
mongoose.connection.once 'open', ->
console.log "Connected to #{config.mongo.uri}"

module.exports = exports = (app) ->

exports['User'] = mongoose.model 'User', require './schemas/User'
exports['Event'] = mongoose.model 'Event', require './schemas/Event'
exports['Family'] = mongoose.model 'Family', require './schemas/Family'
