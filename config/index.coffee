extend = require 'extend'

env = process.env.NODE_ENV or 'development'

publicConf = require './public'
privateConf = require './private'

module.exports = extend true, {}, publicConf, privateConf