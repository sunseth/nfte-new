

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.get paths.public.families.index, (req, res, next) ->
    res.render 'public/families/index'
