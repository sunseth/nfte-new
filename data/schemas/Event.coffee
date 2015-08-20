mongoose = require 'mongoose'
Schema = mongoose.Schema

EventSchema = new Schema(
  name: {type: String, required: [true, 'Name is required'], minlength: [5, 'Event name must be longer than ({MINLENGTH}) characters']}
  date: {type: Date, required: [true, 'Date is required'], min: [new Date, 'Date cannot be in the past']}
  location: String
  description: String
  link: String
  image: {type: String, match: [/^https?:\/\/(?:[a-z0-9\-]+\.)+[a-z]{2,6}(?:\/[^\/#?]+)+\.(?:jpg|gif|png)$/, 'Image must be of type .jpg|.gif|.png']}
)

module.exports = EventSchema