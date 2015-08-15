module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies
  
  aws = require 'aws-sdk'
  fs = require 'fs'
  url = require 'url'
  multer = require 'multer'

  eventApi = app.express.Router()
  eventApi.use require('../../../middleware/dbError')

  eventApi.use multer(
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

  # returns the events collection
  eventApi.get '/', (req, res) ->
    Event.find (err, results) ->
      if err
        next err

      else
        res.send results    

  # create an event
  eventApi.post '/', (req, res) ->
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
  eventApi.get /^\/(\w+$)/, (req, res, next) ->
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

  eventApi.put /^\/(\w+$)/, (req, res, next) ->
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

  eventApi.delete /^\/(\w+$)/, (req, res, next) ->
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

  return eventApi