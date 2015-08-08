

module.exports = (app) ->

  app.controller 'FamiliesController', class FamiliesController
    constructor: (@$scope, @$rootScope, @$http) ->
      @$scope.date = new Date()
      family1 =
        name:'yolo'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
        parents: [{name:'monkey'}, {name:'monkey'}]
      family2 =
        name:'polo'
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
        parents: [{name: 'seth'}, {name: 'seth'}]
      @$scope.families = [family1, family2]