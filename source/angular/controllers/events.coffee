module.exports = (app) ->

  app.controller 'EventController', ($scope, $http, $resource) ->
    eventResource = $resource '/events', {}, {
      'getAll': {
        method: 'GET',
        isArray: true,
        url: '/events/all'
      }
    }

    events = eventResource.getAll (response) ->
      $scope.events = response

    $scope.createEvent = () ->
      newEvent = new eventResource()
      newEvent.eventData = $scope.newEvent
      newEvent.$save (response) ->
        if response.err == undefined
          $scope.events.push $scope.newEvent
          console.log $scope.events
          console.log $scope.newEvent
