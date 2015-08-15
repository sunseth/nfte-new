module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  adminApi = app.express.Router()
  adminApi.use paths.admin.api.events.base, require('./events')(app, dependencies)

  return adminApi