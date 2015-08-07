module.exports = (app, dependencies) ->
  router = app.express.Router() 
  aws = require 'aws-sdk'
  fs = require 'fs'
  url = require 'url'

  bucket = 'tienvcloudtrail2'

  {config, auth, paths, data} = dependencies
  path = paths.events.index
  Event = data.Event

  deletefromS3 = (imageUrl) ->
    tmp = url.parse imageUrl
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

  uploadToS3 = (file, callback) ->
    photoBucket = new aws.S3 {
      params: {
        Bucket: bucket,
        Key: file.originalname
      }
    }

    photoBucket.upload {
      ACL: "public-read",
      Body: fs.createReadStream file.path,
      Key: file.originalname,
      ContentType: file.mimetype,
      ContentEncoding: file.encoding
    }, callback    

  router.get '/', (req, res) ->
    res.render 'events/index'

  router.get '/collection', (req, res) ->
    Event.find (err, results) ->
      if err
        next err

      else
        # returns an array of events
        res.json results    

  # create an event
  router.post '/', (req, res) ->
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

    uploadToS3(file, callback)

  # id specific routes for single event R, U, D
  router.get /^\/(\w+$)/, (req, res, next) ->
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

  router.put /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]
    updatedEvent = req.body
    deleteOld = false

    updateEvent = () ->
      Event
      .findOneAndUpdate(
        _id: eventId
      , updatedEvent
      , {new: false}
      , (err, old) ->
        if err
          next err
        else
          console.log old
          # delete the old image
          if deleteOld
            deletefromS3 old.image
          res.send updatedEvent
      )              

    if req.files['image'] != null
      deleteOld = true
      file = req.files['image']

      callback = (err, data) ->
        if err
          res.send {err: err}
        else
          console.log data
          updatedEvent.image = data['Location']
          updateEvent()

      uploadToS3(file, callback)
    else
    # do not update the image url if no files were posted
      delete updatedEvent['image']
      updateEvent()

  router.delete /^\/(\w+$)/, (req, res, next) ->
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

  router.use errorHandler

  return router