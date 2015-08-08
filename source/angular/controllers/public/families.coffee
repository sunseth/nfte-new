

module.exports = (app) ->

  app.controller 'FamiliesController', class FamiliesController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()