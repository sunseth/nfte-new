
module.exports = (app) ->
  app.directive 'aaaSignupModal', () ->
    return {
      restrict: 'E'
      templateUrl: 'templates/signup.html'
      link: (scope, elem, attrs) ->
        elem = elem.find('.ui.modal')
        scope.$parent.signupModal = elem
        scope.signupModal = elem
        scope.signupModal.modal()
      controller: SignupModal
      controllerAs: 'self'
      scope: {}

    }

  class SignupModal
    constructor: (@$scope) ->

    open: ->
      return @$scope.loginModal.modal('show')

    close: ->
      return @$scope.loginModal.modal('hide')

    submit: ->
      return console.log 'submit'