

module.exports = (app) ->
  app.controller 'CabinetController', class CabinetController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()

      cabinet1 =
        name: 'monkey'
        position : 'President'
        description: 'all I do is win, win, win no matter what'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        hidden: 'http://i.usatoday.net/communitymanager/_photos/game-hunters/2012/01/04/hidden0104x-large.jpg'
      cabinet2 =
        name: 'seth'
        position : 'Intern'
        description: 'whoaaaa oooaaa oooaaa (FOB)'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        hidden: 'http://i.usatoday.net/communitymanager/_photos/game-hunters/2012/01/04/hidden0104x-large.jpg'


      @$scope.cabinet = [cabinet1, cabinet2]