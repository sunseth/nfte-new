

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.post paths.public.events.index, (req, res, next) ->
    console.log req
    res.render 'public/events/index'
