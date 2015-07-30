
module.exports = (app) ->
  app.directive 'aaaLoginModal', () ->
    return {
      restrict: 'A'
      templateUrl: 'templates/login.html'
      link: (scope, elem, attrs) ->
        elem = elem.find('.ui.modal')
        scope.$parent.modal = elem
        scope.modal = elem
        scope.modal.modal()
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