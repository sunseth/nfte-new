
module.exports = (app) ->

  app.controller 'HomeController', class HomeController
    constructor: (@$scope) ->
      @$scope.date = new Date()
      @$scope.openModal = ->
        console.log 'opening'
        @$scope.modal.modal('show')

