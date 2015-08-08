mongoose = require 'mongoose'
Schema = mongoose.Schema

CABINET = ['President', 'Internal Vice President', 'External Vice President',
  'Treasurer', 'Secretary', 'Community Service', 'Development', 'Internal Relations',
  'Issues', 'Social', 'Technology']

CabinetSchema = new Schema(
  name: {type: String, required: true}
  position : {enum: CABINET}
  description: String
  facts: [String]
  image: String
  hidden: String
)

module.exports = CabinetSchema