module.exports = (err, req, res, next) ->
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