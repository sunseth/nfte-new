
module.exports = (app) ->

  app.controller 'HomeController', class HomeController
    constructor: (@$scope) ->
      @$scope.date = new Date()

    openModal: ->
      console.log 'opening'
      @$scope.modal.open()