module.exports = (app, dependencies) ->
  {config, auth, paths, data} = dependencies
  path = paths.events.index

  app.get path, (req, res) ->
    res.render 'events/index'

  app.post path, (req, res) ->
    formData = req.body.eventData
    e = new data.Event(
      name: formData.name,
      description: formData.description,
      image: formData.image,
      date: new Date)

    e.save (err, results) ->
      if err
          res.send {
            err: err
          }
        else
          res.send {
            success: true
          }

  app.get '/events/all', (req, res) ->
    data.Event.find (err, results) ->
      if err
        res.send 500
      else
        # console.log results
        res.send results