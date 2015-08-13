{User} = require '../data'

module.exports = exports = (app) ->

exports.clearance =
  visitor: 0
  user: 1
  moderator: 2
  admin: 3
  production: 4

exports.user = (clearance) ->
  return (req, res, next) ->
    userId = req.session?.passport?.user || req.session?.user?._id

    if !userId
      return next({status: 401, message: "Not logged in, unauthorized"}) if clearance >= 2
      req.user = null
      res.locals.user = null
      return next()

    userParams = '_id firstName lastName email clearance'
    User.findById(userId).select(userParams).lean(true).exec (err, user) ->
      return next(err) if err
      return next({status: 404, message: "Cannot find account for this session"}) unless user
      return next({status: 403, message: "Clearance insufficient, forbidden"}) unless user.clearance >= clearance
      user._id = user._id.toString()
      req.user = user
      res.locals.user = user

      return next()

