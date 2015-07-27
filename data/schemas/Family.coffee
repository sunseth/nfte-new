mongoose = require 'mongoose'
Schema = mongoose.Schema

FamilySchema = (
  name: {type: String, required: true}
  parents: [
    name: String
  ]
  description: String
  members: [
    id: String
  ]
  image: String
)

module.exports = FamilySchema