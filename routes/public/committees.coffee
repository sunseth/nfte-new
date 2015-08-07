

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.get paths.public.committees.index, (req, res, next) ->
    res.render 'public/committees/index'