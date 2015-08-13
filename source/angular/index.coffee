paths = require '../../paths'

app = angular.module 'aaa-website', [
  'ngRoute'
  'ngStorage'
  'ngResource'
  'ngFileUpload'
  'filters'
]

app.run ($rootScope) ->
  $rootScope.paths = paths

require('./directives/login')(app)
require('./directives/signup')(app)
require('./directives/events')(app)

require('./controllers/public/home')(app)
require('./controllers/public/events')(app)
require('./controllers/public/families')(app)
require('./controllers/public/cabinet')(app)
require('./controllers/public/blog')(app)

require('./controllers/admin/events.coffee')(app)

require('./filters/filters')()