module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies
  path = paths.events.index
  Event = data.Event

  router = app.express.Router()

  router.get '/', (req, res) ->
    res.render 'events/index'

  router.get '/all', (req, res, next) ->
    Event.find (err, results) ->
      if err
        next err

      else
        # console.log results
        res.send results

  router.post '/', (req, res) ->
    formData = req.body.eventData
    e = new Event(
      name: formData.name,
      description: formData.description,
      image: formData.image,
      date: new Date)

    e.save (err, result) ->
      if err
        res.send {
          err: err
        }
      else
        res.send {
          success: true
          result: result
        }

  # id specific
  router.get /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]
    Event
    .findOne(
      _id: eventId
    , (err, results) ->
      if err
        next err

      res.send results
    )

  router.put /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]
    updatedEvent = req.body

    # do validation here

    Event
    .findOneAndUpdate(
      _id: eventId
    , updatedEvent
    , {new: true}
    , (err, results) ->
      if err
        next err

      res.send results
    )

  router.delete /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]

    Event
    .findOneAndRemove(
      _id: eventId
    , (err, results) ->
      if err
        next err

      res.send results
    )

  errorHandler = (err, req, res, next) ->
    console.log err.stack
    res.send 'some shit broke'

  router.use errorHandler

  return router