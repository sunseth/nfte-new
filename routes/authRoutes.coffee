passport = require('passport')

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.post paths.public.login.index