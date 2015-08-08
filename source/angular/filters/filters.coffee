module.exports = () ->
  angular.module('filters', []).filter 'search', ->
    return (items, query) ->
      if query in ['', undefined]
        return items
      return _.filter items, (item) ->
        return (item.name.indexOf query) > -1