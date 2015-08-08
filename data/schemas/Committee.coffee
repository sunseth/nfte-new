mongoose = require 'mongoose'
Schema = mongoose.Schema

CommitteeSchema = new Schema(
  name: {type: String, required: true}
  description: String
  projects: Object
  image: String
)

module.exports = CommitteeSchema