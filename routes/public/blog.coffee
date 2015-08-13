
module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  app.get paths.public.blog.index, (req, res, next) ->
    res.render 'public/blog/index'