module.exports = (app) ->
  app.directive 'longname', () ->
    return {
      require: 'ngModel',
      link: (scope, elm, attrs, ctrl) ->
        ctrl.$validators.longname = (modelVal, viewVal) ->
          if viewVal.length > 5
            return true

          return false
    }
  .directive 'filesModel', ($parse) ->
    return {
      link: (scope, element, attrs) ->
        exp = $parse attrs.filesModel

        element.on 'change', () ->
          exp.assign scope, this.files
          scope.$apply
    }