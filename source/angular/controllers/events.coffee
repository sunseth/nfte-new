module.exports = (app) ->

  app.controller 'EventController', ($scope, $http, $resource) ->
    eventResource = $resource '/events/:id',
    {id: '@_id'}, 
    {
      'getCollection': {
        method: 'GET',
        isArray: true,
        url: '/events'
        headers: {
          'Accept': 'application/json'
        }
      }, 
      'put': {
        method: 'PUT',
        url: '/events/:id'
        isArray: false
      }
    }

    eventResource.getCollection '', (results) ->
      $scope.events = results
      # prevent the title updating as the form gets typed out
      for event in $scope.events
        event.title = event.name

    $scope.createEvent = () ->
      event = new eventResource($scope.newEvent)
      event.$save '', () ->
        event.title = event.name
        $scope.events.push event
      , (error) ->
        console.log error

    $scope.deleteEvent = (event, index) ->
      event.$remove (response) ->
        $scope.events.splice(index, 1)

    $scope.put = (index) ->
      $scope.showValidations = true

      eventResource.put {id: this.event._id}, this.event, (response) =>
        this.event.title = this.event.name
      , (error) ->
        console.log error

  .directive 'longname', () ->
    return {
      require: 'ngModel',
      link: (scope, elm, attrs, ctrl) ->
        ctrl.$validators.longname = (modelVal, viewVal) ->
          if viewVal.length > 5
            return true

          return false
    }