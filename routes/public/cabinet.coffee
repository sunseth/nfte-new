

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.get paths.public.cabinet.index, (req, res, next) ->
    res.render 'public/cabinet/index'
