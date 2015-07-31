

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.get paths.public.home.index, (req, res, next) ->
    res.render 'public/home/index'