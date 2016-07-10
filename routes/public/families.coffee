
nodemailer = require 'nodemailer'
smtpTransport = require('nodemailer-smtp-transport')

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


  app.post '/email', (req, res, next) ->
    console.log 'email'
    console.log req.body
    data = req.body.data.split('|')
    fields = {}
    for d in data
        e = d.split(';:')
        fields[e[0]] = e[1]
    console.log fields
    # create reusable transporter object using the default SMTP transport 
    # create reusable transport method (opens pool of SMTP connections)
    smtpTransport = nodemailer.createTransport('SMTP',
      service: 'gmail'
      auth:
        user: 'sunchuning@gmail.com'
        pass: config.ep)
    # setup e-mail data with unicode symbols
    mailOptions = 
      from: fields.from
      to: fields.to
      subject: fields.subject
      text: fields.body
      html: fields.body
    console.log mailOptions
    # send mail with defined transport object
    smtpTransport.sendMail mailOptions, (error, response) ->
      if error
        console.log error
      else
        console.log 'Message sent: ' + response.message
      # if you don't want to use this transport object anymore, uncomment following line
      #smtpTransport.close(); // shut down the connection pool, no more messages
      return

  app.get '/chat', (req, res, next) ->
    res.send req.query

    