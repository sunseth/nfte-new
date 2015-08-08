

module.exports = (app) ->

  app.controller 'EventsController', class EventsController
    constructor: (@$scope, @$rootScope, @$http) ->
