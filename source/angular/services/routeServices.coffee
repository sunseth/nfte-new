module.exports = () ->
  angular.module("routeServices", [])
    .service 'routeTraverse', ($rootScope) ->
      paths = $rootScope.paths
      return {
        resolve: (pathname) ->
          returnPath = ''
          tree = pathname.split '.'
          currentObject = paths

          for item in tree
            if not currentObject
              return -1

            currentObject = currentObject[item]

            # leaf object
            if typeof currentObject == 'string'
              returnPath += currentObject
            else if currentObject['base']
              returnPath += currentObject['base']
            else 
              # no base defined
              continue

          console.log returnPath
          return returnPath
      }