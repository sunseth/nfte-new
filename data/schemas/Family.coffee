mongoose = require 'mongoose'
Schema = mongoose.Schema

FamilySchema = (
  name: {type: String, required: true}
  color: String
  parents: [
    {name: String, image: String}
  ]
  description: String
  chant: [String]
  members: [{id: String}]
  image: String
  thumbnails: [String]
)

module.exports = FamilySchema