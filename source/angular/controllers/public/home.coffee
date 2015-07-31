
module.exports = (app) ->

  app.controller 'HomeController', class HomeController
    constructor: (@$scope) ->
      @$scope.date = new Date()

    openLoginModal: ->
      @$scope.loginModal.modal('show')
      return

    openSignupModal: ->
      @$scope.signupModal.modal('show')
      return

