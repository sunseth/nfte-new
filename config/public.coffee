extend = require 'extend'

env = process.env.NODE_ENV or 'development'

base =
  home:
    port: 8080
    externalPort: 80

  analytics:
    google:
      id: ''

config =
  development: extend true, {}, base,
    home:
      externalPort: 8080

  test: extend true, {}, base

  stage: extend true, {}, base,
    home:
      host: 'aaa.sethsun.com'
      protocol: 'http'

  production: extend true, {}, base,
    home:
      port: 8080
      host: 'aaaberkeley.com'
      protocol: 'http'

module.exports = config[env] || {}

# Provide the current env for easy access
module.exports.env = env