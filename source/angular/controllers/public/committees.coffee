

module.exports = (app) ->

  app.controller 'CommitteesController', class CommitteesController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()
      com1 =
        name:'yolo'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
      com2 =
        name:'polo'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
      @$scope.committees = [com1, com2]