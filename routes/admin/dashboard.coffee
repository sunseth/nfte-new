module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  admin = app.express.Router()

  # enforce clearance of 3 for admin site
  app.use paths.admin.base, auth.user(1), admin
  adminPublic = app.express.Router()

  admin.use '/', adminPublic
  admin.use paths.admin.api.base, require('./api/index')(app, dependencies)
  adminPublic.get '/', (req, res) ->
    res.render 'admin/events'

  return admin