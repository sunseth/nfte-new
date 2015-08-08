module.exports = (app) ->
  app.controller 'EventController', ['$scope', '$http', '$resource', '$timeout', 'Upload', ($scope, $http, $resource, $timeout, Upload) ->
    $scope.onFileSelect = (files) ->
      console.log files

      if files.length > 0
        filename = files[0].name
        type = files[0].type
        query = 
          filename: filename
          type: type
        # $http.post('/events', query).success((result) ->
        Upload.upload(
          url: '/events'
          # fields: query
          method: 'POST'
          file: files).progress((evt) ->
          console.log 'progress: ' + parseInt(100.0 * evt.loaded / evt.total)
          return
        ).success((data, status, headers, config) ->
          # file is uploaded successfully
          console.log 'file ' + config.file.name + 'is uploaded successfully. Response: ' + data
          return
        ).error ->
          console.log 'error'
        # ).error (data, status, headers, config) ->
        #   # called asynchronously if an error occurs
        #   # or server returns response with an error status.
        #   return
      return

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

    eventResource = $resource '/events/:id',
    {id: '@_id'}, 
    {
      'getCollection': {
        method: 'GET',
        isArray: true,
        url: '/events/collection'
      }, 
      'put': {
        method: 'PUT',
        url: '/events/:id',
        isArray: false,
        headers: {
          'Content-Type': undefined
        }
        transformRequest: toMultipartForm
      },
      'savey': {
        method: 'POST',
        isArray: false,
        url: '/events/:id',
        headers: {
          'Content-Type': undefined
        },
        transformRequest: toMultipartForm
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

    eventResource.getCollection '', (results) ->
      $scope.events = results

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
      # newEvent = $scope.newEvent

      # console.log newEvent
      # eventResource.save {id: newEvent._id}, newEvent, (response) =>
      event.$savey {}, (newEvent) ->
        event.title = event.name
        event.imageUrl = newEvent.image

        $scope.events.push event
      , (error) ->
        console.log error

    $scope.deleteEvent = (event, index) ->
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