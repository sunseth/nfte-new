

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
        parents: [{name:'Michelle', image: 'https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xpf1/v/t1.0-9/10998011_832611260117936_3932034622428075156_n.jpg?oh=b987692866bc2abb5f3898053001789c&oe=563D325E'},
        {name:'Kathy', image: 'https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/1606992_10205508009673423_7104651028651402931_n.jpg?oh=89eed60427f4951e517fafdb459e71fd&oe=564425C8'},
        {name: 'Mitchie', image: 'https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xft1/v/t1.0-9/11781810_1609731899295688_4598194794072730615_n.jpg?oh=2480c803a923c151cd47846972eda383&oe=5674E33D'}]
      @$scope.families = [family1]

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