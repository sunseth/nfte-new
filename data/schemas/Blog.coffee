mongoose = require 'mongoose'
Schema = mongoose.Schema

BlogSchema = new Schema(
  name: {type: String, required: true}
  author: String
  date: {type: Date, required: true}
  components: [
    paragraph: String
    image: String
  ]
)

module.exports = BlogSchema