

module.exports = (app) ->

  app.controller 'FamiliesController', class FamiliesController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()
      @$http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
      @$scope.$watch('userEmail',  () =>
          data = "email=" + @$scope.userEmail
          console.log data
          @$http(
            url: '/dashboard'
            method: 'POST'
            data: data).then ((res) =>
            # success
            console.log res
            @$scope.userRole = res.data.user.role
            @$scope.userName = res.data.user.firstName
            @$scope.profilePic = res.data.user.picture
            @$scope.matches = res.data.matches
            
            return
          ), (res) ->

            # optional
            # failed
            return
      );

    openLoginModal: ->
      @$scope.loginModal.modal('show')
      return

    openSignupModal: ->
      @$scope.signupModal.modal('show')
      return

    logout: ->
      @$http.post(@$rootScope.paths.public.logout, {})
        .success (res) =>
          return location.reload()
        .error (err) =>
          return @$scope.error = err