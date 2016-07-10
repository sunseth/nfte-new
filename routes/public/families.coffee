

module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies
  {User} = data

  app.get paths.public.families.index, (req, res, next) ->
    res.render 'public/families/index'

  app.post '/dashboard', (req, res, next) ->
  	console.log 'dashboard!'
  	email = req.body.email
  	User.findOne({email: email}).exec (err, user) ->
  		console.log user
  		match = ""
  		if user.toObject().role == 'Student'
  			match = 'Mentor'
  		else
  			match = 'Student' 
  		matchInterests = user.toObject().interests
  		console.log matchInterests, match
  		User.find({role: match, interests: {$in: matchInterests}}).exec (err, matches) ->
  			console.log matches
  			resObj = 
  				user: user
  				matches: matches
  			res.send resObj