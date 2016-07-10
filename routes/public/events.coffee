

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies
  {User} = data

  app.get paths.public.events.index, (req, res, next) ->
    res.render 'public/events/index'

  app.post '/profile', (req, res, next) ->
    console.log 5
    console.log req.body
    data = req.body.data.split(';')
    console.log data
    obj = {}
    console.log obj
    for d in data
      e = d.split('|')
      console.log e
      obj[e[0]] = e[1]
    console.log obj
    console.log obj['email']
    User.findOne({email: obj['email']}).exec (err, user) ->
      console.log user
      user.bio = obj['bio']
      user.interests = obj['interests'].split(',')
      user.role = obj['role']
      user.company = obj['company']
      user.school = obj['school']
      user.picture = obj['picture']
      user.save (err) ->
        res.send(user.toObject())

  app.post '/retrieve', (req, res, next) ->
    console.log req.body
    console.log 5
    User.findOne({email: req.body.email}).exec (err, user) ->
      console.log user
      if (err || !user)
        res.send null
      res.send user.toObject()

