
openChatModel1 = () ->
  $('.ui.modal.chat')
      .modal('show')

ioListen1 = (email) ->
  socket.on(email, (data)->
    str = data.name + ': ' + data.msg + '\n'
    $('#textBox1').append(str)
  )

ioSend1 = (email, msg, name) ->
  $('#chatBox1').val('')
  str = name + ': ' + msg + '\n'
  $('#textBox1').append(str)
  socket.emit('message', {email:email, msg: msg, name:name})

module.exports = (app) ->

  app.controller 'EventsController', class EventsController
    constructor: (@$scope, @$rootScope, @$http, @$window) ->
      @$scope.date = new Date()
      @$scope.role = "Student"

      @$http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";

      @$scope.$watch('userEmail',  () =>
          data = "email=" + @$scope.userEmail
          @$http(
            url: '/retrieve'
            method: 'POST'
            data: data).then ((res) =>
            # success
            console.log res
            @$scope.userPicture = res.data.picture
            @$scope.userRole = res.data.role
            @$scope.userDate = res.data.date
            @$scope.userBio = res.data.bio
            @$scope.userName = res.data.firstName
            @$scope.userEmail = res.data.email
            @$scope.userInterests = res.data.interests.join(', ')
            @$scope.userCompany = res.data.company
            @$scope.userSchool = res.data.userSchool
            ioListen1(@$scope.userEmail)
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

    openChat: (name) ->
      openChatModel1()
      @$scope.chatName = name

    submit: (form) ->
      form.email = @$scope.userEmail
      form.role = @$scope.role
      console.log form
      data = []
      for prop, val of form
        console.log prop, val
        data.push prop+"|"+val
      data = data.join(';')
      console.log data
      @$scope.loading = true
      @$http.post('/profile', "data="+data)
        .success (res) =>
          console.log res
          @$scope.userPicture = res.picture
          @$scope.userRole = res.role
          @$scope.userDate = res.date
          @$scope.userBio = res.bio
          @$scope.userEmail = res.email
          @$scope.userInterests = res.interests.join(', ')
          @$scope.userCompany = res.company
          @$scope.userSchool = res.userSchool

        .error (err) =>
          return @$scope.error = err.message || err || "Internal server error"
        .finally () =>
          delete @$scope.loading
          return

    logout: ->
      @$http.post(@$rootScope.paths.public.logout, {})
        .success (res) =>
          return @$window.location.href = '/'
        .error (err) =>
          return @$scope.error = err

    learning: ->
      @$scope.role = "Student"
    teaching: ->
      @$scope.role = "Mentor"

  app.directive 'chat1', ->
    (scope, element, attrs) ->
      element.bind 'keydown keypress', (event) ->
        if event.which == 13
          ioSend1(scope.userEmail, scope.chatText, scope.userName)
          event.preventDefault()
        return
      return