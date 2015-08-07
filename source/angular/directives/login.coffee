
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
      scope: {}
    }

  class LoginModal
    constructor: (@$scope, @$http, @$rootScope, @$route) ->

    open: ->
      return @$scope.loginModal.modal('show')

    close: ->
      return @$scope.loginModal.modal('hide')

    submit: (form) ->
      return if @$scope.loading
      @$scope.loading = true
      @$http.post(@$rootScope.paths.public.login, form)
        .success (res) =>
          @close()
          return location.reload()
        .error (err) =>
          return @$scope.error = err
        .finally () =>
          delete @$scope.loading