passport = require('passport')

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies

  loginOptions = {failureFlash: 'Invalid username or password.'}
  app.post paths.public.login, passport.authenticate('local', loginOptions), (req, res) ->
    res.redirect(paths.public.home.index)

