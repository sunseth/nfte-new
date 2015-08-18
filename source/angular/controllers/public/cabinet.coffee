

module.exports = (app) ->
  app.controller 'CabinetController', class CabinetController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()

      cabinet1 =
        name: 'monkey'
        position : 'President'
        facts: ['fdasf','fdas','afds']
        description: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system,
          and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.
          Nor again is there anyone who loves or pursues or"
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        hidden: 'http://i.usatoday.net/communitymanager/_photos/game-hunters/2012/01/04/hidden0104x-large.jpg'


      @$scope.cabinet = [cabinet1]

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