config = require '../../config'
paths = require '../../paths'
dependencies = {config, paths}

app = angular.module 'aaa-website', []
app.run ($rootScope) ->
  $rootScope.paths = paths



require('./controllers/home')(app, dependencies)
require('./controllers/events')(app, dependencies)
require('./controllers/families')(app, dependencies)
require('./controllers/cabinet')(app, dependencies)
require('./controllers/blog')(app, dependencies)