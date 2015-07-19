

module.exports = (app, dependencies) ->
  {config, paths, auth} = dependencies

  app.get paths.home.index, (req, res, next) ->
    res.render 'home/index.ejs'