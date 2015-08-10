mongoose = require 'mongoose'
Schema = mongoose.Schema

EventSchema = new Schema(
  name: {type: String, required: true}
  date: {type: Date, required: true}
  location: String
  description: String
  link: String
  image: String
)

module.exports = EventSchema