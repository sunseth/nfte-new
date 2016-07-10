
module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies
  {User} = data

  app.post paths.public.profile, (req, res, next) ->
    console.log('object is', req.body)
    userQuery =
      email: req.body.email

    User.findOne(userQuery).exec (err, user) ->
      console.log user
      user.lastName = req.body.lastName
      user.save (err) ->
        return next(err) if err

    return next({status: 200, message: "Success"})
