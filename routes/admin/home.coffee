module.exports = (app, dependencies) ->
  aws = require 'aws-sdk'
  fs = require 'fs'
  url = require 'url'
  multer = require 'multer'

  {config, auth, paths, data} = dependencies

  errorHandler = (err, req, res, next) ->
    # console.log err.stack
    console.log err

    if err.name == 'CastError'
      # additional error logic here
      console.log 'cast error'
    # other error types...

    console.log 'some shit broke'
    res.status(500).send {
      success: false,
      msg: 'some shit broke',
      stack: err.stack
    }

  adminRouter = app.express.Router()

  # enforce clearance of 3 for admin site
  app.use paths.admin.prefix, auth.user(3), adminRouter

  eventRouter = app.express.Router()
  eventRouter.use errorHandler
  adminRouter.use paths.admin.events, eventRouter

  eventRouter.use multer(
    limit:
      fieldNameSize: 100
      fieldSize: 5
    dest: './uploads/'
    rename: (fieldname, filename) ->
      filename + Date.now()
    onFileUploadStart: (file) ->
      console.log file.originalname + ' is starting ...'
      return
    onFileUploadComplete: (file) ->
      console.log file.fieldname + ' uploaded to  ' + file.path
      done = true
      return
    onFieldsLimit: ->
      console.log 'Crossed fields limit!'
      return
  )

  bucket = 'tienvcloudtrail2'
  Event = data.Event

  deletefromS3 = (imageUrl) ->
    tmp = url.parse unescape(imageUrl)
    key = tmp.pathname.slice 1

    photoBucket = new aws.S3 {
      params: {
        Bucket: bucket,
        Key: ''
      }
    }
    photoBucket.deleteObject {
      Key: key
    }, (err, data) ->
      if err
        console.log err
      else
        console.log 'deleted ' + key

  uploadToS3 = (file, separator, callback) ->
    photoBucket = new aws.S3.ManagedUpload {
      params: {
        Bucket: bucket,
        Key: separator + '/' + file.name,
        ACL: "public-read",
        Body: fs.createReadStream file.path,
        ContentType: file.mimetype,
        ContentEncoding: file.encoding
      }
    }

    photoBucket.send callback

  eventRouter.get '/', (req, res) ->
    res.render 'admin/events'

  eventRouter.get '/collection', (req, res) ->
    Event.find (err, results) ->
      if err
        next err

      else
        # returns an array of events
        res.send results    

  # create an event
  eventRouter.post '/', (req, res) ->
    file = req.files['image']

    callback = (err, data) ->
      if err
        console.log err
        res.send {err: err}
      else
        e = new Event(req.body)
        e.image = data['Location']
        e.save (err, result) ->
          if err
            console.log err
            res.send {err: err}
          else
            res.send result

    uploadToS3(file, req.user.email, callback)

  # id specific routes for single event R, U, D
  eventRouter.get /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]
    Event
    .findOne(
      _id: eventId
    , (err, results) ->
      if err
        next err
      else
        res.send results
    )

  eventRouter.put /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]
    updatedEvent = req.body

    updateEvent = (event, deleteOld) ->
      console.log event
      Event
      .findOneAndUpdate(
        _id: eventId,
        event,
        {new: false},
        (err, old) ->
          if err
            next err
          else
            if deleteOld
              deletefromS3 old.image
            res.send event
      )

    if req.files['image'] != undefined
      deleteOld = true
      uploadToS3 req.files['image'], req.user.email, (err, data) ->
        updatedEvent.image = data['Location']
        updateEvent updatedEvent, true
    else
      updateEvent updatedEvent, false

  eventRouter.delete /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]

    Event
    .findOneAndRemove(
      _id: eventId
    , (err, event) ->
      if err
        next err
      else
        deletefromS3 event.image
        res.send event
    )

  return eventRouter