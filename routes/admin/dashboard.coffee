

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.get paths.admin.dashboard.index, auth.user(3), (req, res, next) ->
    res.render 'admin/dashboard/index'