

module.exports = (app) ->

  app.controller 'FamiliesController', class FamiliesController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()
      family1 =
        name:'yolo'
        color: 'black'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        thumbnails: [
          'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg',
        ]
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
        parents: [{name:'monkey'}, {name:'monkey'}]
      family2 =
        name:'polo'
        color: 'red'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
        parents: [{name: 'seth'}, {name: 'seth'}]
      @$scope.families = [family1, family2]

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