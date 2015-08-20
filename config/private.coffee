extend = require 'extend'

env = process.env.NODE_ENV or 'development'

base =
  mongo:
    uri: 'mongodb://localhost:27017/aaa'
    options:
      server:
        socketOptions: { keepAlive: 1, connectTimeoutMS: 60000 }

  redis:
    port: 6379
    host: 'localhost'
    secret: '162FzhDGCJ5lrprE37H4cRa8nu5em4eW'
    db: 1

  middleware:
    trustProxy: '127.0.0.1'

  s3:
    accountId: 'AKIAIHQARFMAXKSUXFMA'
    secretKey: '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'
    bucket: 'tienvcloudtrail2'

  facebook:
    clientId: ''
    clientSecret: ''

  google:
    clientId: ''
    clientSecret: ''

config =
  development: extend true, {}, base

  test: extend true, {}, base,
    mongo:
      uri: 'mongodb://localhost:27017/test'

  stage: extend true, {}, base,
    mongo:
      uri: 'aaa.sethsun.com/aaa'

  production: extend true, {}, base,
    mongo:
      uri: 'mongodb://localhost:27017/primary'
      options:
        replset:
          rs_name: 'rs0'
          socketOptions: { keepAlive: 1, connectTimeoutMS: 30000 }

    s3:
      accountId: 'AKIAIHQARFMAXKSUXFMA'
      secretKey: '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'
      bucket: 'aaa-prod'

module.exports = config[env] || {}

module.exports.env = env