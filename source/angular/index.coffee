config = require '../../config'
paths = require '../../paths'

app = angular.module 'aaa-website', ['ngResource', 'ngFileUpload', 'ui.timepicker']
app.run ($rootScope) ->
  $rootScope.paths = paths
  $rootScope.config = config

require('./directives/login')(app)

require('./controllers/home')(app)
require('./controllers/events')(app)
require('./controllers/families')(app)
require('./controllers/cabinet')(app)
require('./controllers/blog')(app)