
module.exports = (app) ->
  app.directive 'aaaLoginModal', () ->
    return {
      restrict: 'E'
      templateUrl: 'templates/login.html'
      link: (scope, elem, attrs) ->
        elem = elem.find('.ui.modal')
        scope.$parent.loginModal = elem
        scope.loginModal = elem
        scope.loginModal.modal()
      controller: LoginModal
      controllerAs: 'self'
    }

  class LoginModal
    constructor: (@$scope) ->

    open: ->
      return @$scope.loginModal.modal('show')

    close: ->
      return @$scope.loginModal.modal('hide')

    submit: ->
      return console.log 'submit'