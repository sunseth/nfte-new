
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
    constructor: (@$scope, @$http, @$rootScope, @$route) ->

    open: ->
      return @$scope.signupModal.modal('show')

    close: ->
      return @$scope.signupModal.modal('hide')

    submit: (form) ->
      return if @$scope.loading
      delete @$scope.error
      return unless @validate form
      @$scope.loading = true
      @$http.post(@$rootScope.paths.public.signup, form)
        .success (res) =>
          return location.reload()
        .error (err) =>
          return @$scope.error = err.message || err || "Internal server error"
        .finally () =>
          delete @$scope.loading
          return

    validate: (form) ->
      errors = []
      if !form.email
        errors.push "Email field left blank"
      unless /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(form.email)
        errors.push "Invalid email address"
      if form.password.length < 8
        errors.push "Password must be at least 8 characters in length"
      if form.password != form.confirm
        errors.push "Password and confirmation do not match"
      @$scope.error = errors if errors.length
      return errors.length == 0