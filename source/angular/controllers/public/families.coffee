openEmailModal = () ->
  $('.ui.modal.email')
    .modal('show')

closeEmailModal = () ->
  console.log 56
  $('.ui.modal.email').hide()
  $('.ui.modal').modal('hideDimmer')

openChatModel = () ->
  $('.ui.modal.chat')
      .modal('show')

ioListen = (email) ->
  socket.on(email, (data)->
    console.log 'recieving'
    console.log data
  )

ioSend = (email, msg) ->
  console.log 'sending'
  socket.emit(email, {msg:msg})
module.exports = (app) ->

  app.controller 'FamiliesController', class FamiliesController
    constructor: (@$scope, @$rootScope, @$http, @$window) ->
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
            ioListen(@$scope.userEmail)
            
            return
          ), (res) ->

            # optional
            # failed
            return
      )
      angular.element("emailModal").show()

    openLoginModal: ->
      @$scope.loginModal.modal('show')
      return

    openSignupModal: ->
      @$scope.signupModal.modal('show')
      return

    openChat: (name)->
      console.log 4
      openChatModel()
      @$scope.chatName = name
      return

    setEmail: (name, email) ->
      console.log 55, name, email
      openEmailModal()
      @$scope.emailName = name
      @$scope.emailAddress = email

    sendEmail: () ->
      closeEmailModal()
      dataString = "from;:" + @$scope.userEmail + "|" +
                   "to;:" + @$scope.emailAddress + "|" +
                   "subject;:" + @$scope.emailTitle + "|" +
                   "body;:" + @$scope.emailBody 
      data = "data=" + dataString
      @$http(
          url: '/email'
          method: 'POST'
          data: data).then ((res) =>
          # success
          console.log res

          
          return
        ), (res) ->

          # optional
          # failed
          return

    logout: ->
      @$http.post(@$rootScope.paths.public.logout, {})
        .success (res) =>
          return
        .error (err) =>
          return @$scope.error = err


  app.directive 'myCoolDirective', ->
    {
      restrict: 'A'
      link: (scope, elem, attrs) ->
        elem.bind 'click', ->
          console.log 6
          $('.ui.red.basic.button').show()
          return
        return

    }