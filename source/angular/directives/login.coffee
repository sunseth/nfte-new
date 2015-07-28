
module.exports = (app) ->
  app.directive 'aaa-login', () ->
    return {
      restrict: 'A'
      replace: 'true'
      template: '../templates/login.html'
      link: (scope, elem, attrs) ->
        scope.modal = elem.modal
      controller: Modal
      controllerAs: 'self'
    }

  class Modal
    constructor: (@$scope) ->

    open: ->
      return @$scope.modal.modal('show')

    close: ->
      return @$scope.modal.modal('hide')

    submit: ->
      return console.log 'submit'