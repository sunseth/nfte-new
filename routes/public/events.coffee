

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.get paths.public.events.index, (req, res, next) ->
    res.render 'public/events/index'
