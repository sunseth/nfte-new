bcrypt = require 'bcryptjs'
mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema(

  firstName: {type: String, required: true}
  lastName: {type: String, required: true}
  email: {type: String, required: true, unique: true}
  role: String
  bio: String
  interests: [String]
  school: String
  company: String
  picture: String
  password: String
  passwordReset: String
  salt: String
  # facebook:
  #   id: {type: String, unique: true}
  #   accessToken: String
  #   refreshToken: String
  # google:
  #   id: {type: String, unique: true}
  #   accessToken: String
  #   refreshToken: String
  clearance: {type: Number, default: 1}

)

UserSchema.methods =
  authenticate: (passwordText) ->
    return @encrypt(passwordText) is @password

  setPassword: (passwordText) ->
    @salt = bcrypt.genSaltSync 11
    @password = @encrypt(passwordText)

  encrypt: (passwordText) ->
    return bcrypt.hashSync passwordText, @salt

UserSchema.index {'name': 1}
UserSchema.index {'email': 1}

module.exports = UserSchema

