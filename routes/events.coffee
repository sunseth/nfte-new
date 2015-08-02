module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies
  path = paths.events.index
  Event = data.Event

  router = app.express.Router()

  # router.get '/', (req, res) ->
  #   Event
  #   .findOneAndUpdate(
  #     _id: '55bbe68f590e4a0baea5cf68'
  #   , {name: 'HELLO'}
  #   , {new: true}
  #   , (err, result) ->
  #     if err
  #       next err
  #     else
  #       console.log result
  #   )
  #   res.render 'events/index'


  router.get '/', (req, res) ->
    # get all events
    if 'application/json' in req.headers.accept || 'application/json' in [req.headers.accept]
      Event.find (err, results) ->
        if err
          next err

        else
          # returns an array of events
          res.send results
    else
      res.render 'events/index'

  # create an event
  router.post '/', (req, res) ->
    e = new Event(req.body)
    e.date = new Date

    e.save (err, result) ->
      if err
        res.send {
          err: err
        }
      else
        res.send result

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
    # do validation here

    Event
    .findOneAndUpdate(
      _id: eventId
    , updatedEvent
    , {new: true}
    , (err, result) ->
      if err
        next err
      else
        res.send result
    )

  router.delete /^\/(\w+$)/, (req, res, next) ->
    eventId = req.params[0]

    Event
    .findOneAndRemove(
      _id: eventId
    , (err, event) ->
      if err
        next err
      else
        res.send event
    )

  errorHandler = (err, req, res, next) ->
    console.log err.stack
    console.log 'some shit broke'
    res.status(500).send {
      success: false,
      msg: 'some shit broke',
      stack: err.stack
    }

  router.use errorHandler

  return router