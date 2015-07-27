bcrypt = require 'bcryptjs'
mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema(

  name: {type: String, required: true}
  email: {type: String, required: true, unique: true}
  phone: String
  password: String
  passwordReset: String
  salt: String
  facebook:
    id: {type: String, unique: true}
    accessToken: String
    refreshToken: String
  google:
    id: {type: String, unique: true}
    accessToken: String
    refreshToken: String
  clearance: {type: String, enum: ['user', 'moderator','admin', 'production']}

)

UserSchema.methods =
  authenticate: (passwordText) ->
    return @encrypt(passwordText) is @password

  setPassword: (passwordText) ->
    @salt = bcrypt.genSaltSync 11
    @password = @encryt passwordText

  encryt: (passwordText) ->
    return bcrypt.hashSync passwordText, @salt

UserSchema.index {'name': 1}
UserSchema.index {'email': 1}

module.exports = UserSchema

