

module.exports = (app) ->

  app.controller 'CommitteesController', class CommitteesController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()