module.exports = (app) ->
  app.controller 'EventController', ['$scope', '$http', '$resource', 'Upload', '$rootScope', ($scope, $http, $resource, Upload, $rootScope) ->
    toMultipartForm = (data, headersGetter) ->
      if (data == undefined)
        return data;

      fd = new FormData
      angular.forEach data, (value, key) ->
        if value instanceof FileList
          if value.length == 1
            fd.append(key, value[0]);
          else
            angular.forEach value, (file, index) -> 
              fd.append(key + '_' + index, file)
        else
          fd.append(key, value);

      return fd;
    
    backendPath = $rootScope.paths.admin.prefix + $rootScope.paths.admin.events
    eventPath = backendPath + '/:id'
    eventResource = $resource eventPath,
    {id: '@_id'}, 
    {
      'getCollection': {
        method: 'GET',
        isArray: true,
        url: backendPath + '/collection'
      }, 
      'put': {
        method: 'PUT',
        url: eventPath,
        isArray: false,
        headers: {
          'Content-Type': undefined
        }
        transformRequest: toMultipartForm
      },
      'create': {
        method: 'POST',
        isArray: false,
        url: eventPath,
        headers: {
          'Content-Type': undefined
        },
        transformRequest: toMultipartForm,
        interceptor: {
          response: (response) ->
            console.log 'DITME RESPONSE'
            console.log response
            return response
        }
      }
    }

    # initialize datetimepicker of the new event form
    angular.element(document).ready () ->
      setTimeout () ->
        angular.element('#newEventDate').datetimepicker {
          format: 'd M Y H:i'
          value: new Date
        }
      , 0

    e = new eventResource {_id: '55cd4bfd30af45b18c173b41'}
    e.$get('').then (results) ->
      console.log results

    eventResource.getCollection '', (results) ->
      $scope.events = results
      console.log results

      # prevent the title updating as the form gets typed out
      for event in $scope.events
        event.title = event.name
        event.imageUrl = event.image

      i = 0

      # initialize the datetimepickers for the events
      angular.element(document).ready () ->
        setTimeout () ->
          for event in $scope.events
            angular.element('.datepicker:eq(' + i.toString() + ')').datetimepicker({
              format: 'd M Y H:i',
              value: new Date event.date
            })
            i++
        , 0

    $scope.createEvent = () ->
      if $scope.newEvent.date in ['', undefined]
        $scope.newEvent.date = new Date

      event = new eventResource($scope.newEvent)
      event.$create {}, (response) ->
        newEvent = response.data
        newEvent.title = newEvent.name
        newEvent.imageUrl = newEvent.image
        delete newEvent['image']

        console.log event
        console.log newEvent
        $scope.events.push newEvent
      , (error) ->
        console.log error

    $scope.deleteEvent = (event, index) ->
      console.log 'deleting'
      event.$remove (response) ->
        $scope.events.splice(index, 1)

    $scope.put = (index) ->
      $scope.showValidations = true
      eventResource.put {id: this.event._id}, this.event, (response) =>
        this.event.imageUrl = response.image
        this.event.title = this.event.name
      , (error) ->
        console.log error
  ]
  .directive 'longname', () ->
    return {
      require: 'ngModel',
      link: (scope, elm, attrs, ctrl) ->
        ctrl.$validators.longname = (modelVal, viewVal) ->
          if viewVal.length > 5
            return true

          return false
    }
    # prototype shit that doesn't work
    # $scope.onFileSelect = (files) ->
    #   console.log files

    #   if files.length > 0
    #     filename = files[0].name
    #     type = files[0].type
    #     query = 
    #       filename: filename
    #       type: type
    #     # $http.post('/events', query).success((result) ->
    #     Upload.upload(
    #       url: '/events'
    #       # fields: query
    #       method: 'POST'
    #       file: files).progress((evt) ->
    #       console.log 'progress: ' + parseInt(100.0 * evt.loaded / evt.total)
    #       return
    #     ).success((data, status, headers, config) ->
    #       # file is uploaded successfully
    #       console.log 'file ' + config.file.name + 'is uploaded successfully. Response: ' + data
    #       return
    #     ).error ->
    #       console.log 'error'
    #     # ).error (data, status, headers, config) ->
    #     #   # called asynchronously if an error occurs
    #     #   # or server returns response with an error status.
    #     #   return
    #   return
