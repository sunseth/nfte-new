(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var app, paths;

paths = require('../../paths');

app = angular.module('aaa-website', ['ngRoute', 'ngResource', 'filters', 'routeServices', 'eventsApiResource']);

app.run(function($rootScope) {
  return $rootScope.paths = paths;
});

require('./directives/login')(app);

require('./directives/signup')(app);

require('./directives/events')(app);

require('./controllers/public/home')(app);

require('./controllers/public/events')(app);

require('./controllers/public/families')(app);

require('./controllers/public/committees')(app);

require('./controllers/public/cabinet')(app);

require('./controllers/public/blog')(app);

require('./controllers/admin/config.coffee')(app);

require('./controllers/admin/admin.coffee')(app);

require('./controllers/admin/index.coffee')(app);

require('./controllers/admin/events.coffee')(app);

require('./controllers/admin/families.coffee')(app);

require('./controllers/admin/cabinet.coffee')(app);

require('./controllers/admin/committees.coffee')(app);

require('./controllers/admin/blog.coffee')(app);

require('./filters/filters')();

require('./services/routeServices')();

require('./services/eventsApiResource')();



},{"../../paths":3,"./controllers/admin/admin.coffee":5,"./controllers/admin/blog.coffee":6,"./controllers/admin/cabinet.coffee":7,"./controllers/admin/committees.coffee":8,"./controllers/admin/config.coffee":9,"./controllers/admin/events.coffee":10,"./controllers/admin/families.coffee":11,"./controllers/admin/index.coffee":12,"./controllers/public/blog":13,"./controllers/public/cabinet":14,"./controllers/public/committees":15,"./controllers/public/events":16,"./controllers/public/families":17,"./controllers/public/home":18,"./directives/events":19,"./directives/login":20,"./directives/signup":21,"./filters/filters":22,"./services/eventsApiResource":23,"./services/routeServices":24}],2:[function(require,module,exports){
module.exports = {
  base: '/admin',
  api: {
    base: '/api',
    events: {
      base: '/events',
      event: '/'
    }
  },
  "public": {
    events: '/events'
  }
};



},{}],3:[function(require,module,exports){
module.exports = {
  "public": require('./public'),
  admin: require('./admin'),
  forbidden: '403.ejs',
  notFound: '404.ejs'
};



},{"./admin":2,"./public":4}],4:[function(require,module,exports){
module.exports = {
  home: {
    index: '/'
  },
  login: '/login',
  logout: '/logout',
  signup: '/signup',
  events: {
    index: '/events'
  },
  families: {
    index: '/families'
  },
  committees: {
    index: '/committees'
  },
  cabinet: {
    index: '/cabinet'
  },
  blog: {
    index: '/blog'
  },
  profile: '/profile'
};



},{}],5:[function(require,module,exports){
module.exports = function(app) {
  return app.controller('AdminMainController', function($scope, $location) {
    $location.path('/index');
    return $scope.change = function(path) {
      $location.path(path);
      return $scope.activeTab = path.slice(1);
    };
  });
};



},{}],6:[function(require,module,exports){
module.exports = function(app) {
  return app.controller('AdminBlogController', function($scope, $location) {});
};



},{}],7:[function(require,module,exports){
module.exports = function(app) {
  return app.controller('AdminCabinetController', function($scope, $location) {});
};



},{}],8:[function(require,module,exports){
module.exports = function(app) {
  return app.controller('AdminCommitteeController', function($scope, $location) {});
};



},{}],9:[function(require,module,exports){
module.exports = function(app) {
  return app.config(function($routeProvider, $locationProvider) {
    $locationProvider.html5Mode({
      enabled: false,
      requireBase: false
    });
    return $routeProvider.when('/index', {
      templateUrl: '/partials/admin.html',
      controller: 'AdminIndexController'
    }).when('/events', {
      templateUrl: '/partials/events.html',
      controller: 'AdminEventController'
    }).when('/blog', {
      templateUrl: '/partials/blogs.html',
      controller: 'AdminBlogController'
    }).when('/cabinet', {
      templateUrl: '/partials/cabinet.html',
      controller: 'AdminCabinetController'
    }).when('/committees', {
      templateUrl: '/partials/committees.html',
      controller: 'AdminCommitteeController'
    }).when('/families', {
      templateUrl: '/partials/families.html',
      controller: 'AdminFamilyController'
    }).otherwise({
      templateUrl: '/partials/dashboard.html',
      controller: 'AdminDashboardController'
    });
  });
};



},{}],10:[function(require,module,exports){
module.exports = function(app) {
  return app.controller('AdminEventController', function($scope, $resource, $rootScope, $location, routeTraverse, eventsApi) {
    var eventPath, eventResource, eventsPath, eventsResource;
    angular.element('.ui.accordion').accordion();
    eventsPath = routeTraverse.resolve('admin.api.events');
    eventPath = routeTraverse.resolve('admin.api.events.event') + ':id';
    eventsResource = eventsApi.events(eventsPath);
    eventResource = eventsApi.event(eventPath);
    angular.element(document).ready(function() {
      return setTimeout(function() {
        return angular.element('#newEventDate').datetimepicker({
          format: 'd M Y H:i',
          value: new Date
        });
      }, 0);
    });
    eventsResource.query('', function(results) {
      var event, i, _i, _len, _ref;
      $scope.events = results;
      _ref = $scope.events;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        event = _ref[_i];
        event.title = event.name;
        event.imageUrl = event.image;
      }
      i = 0;
      return angular.element(document).ready(function() {
        return setTimeout(function() {
          var _j, _len1, _ref1, _results;
          _ref1 = $scope.events;
          _results = [];
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            event = _ref1[_j];
            angular.element('.datepicker:eq(' + i.toString() + ')').datetimepicker({
              format: 'd M Y H:i',
              value: new Date(event.date)
            });
            _results.push(i++);
          }
          return _results;
        }, 0);
      });
    });
    $scope.createEvent = function() {
      var event, _ref;
      if ((_ref = $scope.newEvent.date) === '' || _ref === (void 0)) {
        $scope.newEvent.date = new Date;
      }
      event = new eventsResource($scope.newEvent);
      return event.$create({}, function(response) {
        var newEvent;
        newEvent = response.data;
        newEvent.title = newEvent.name;
        newEvent.imageUrl = newEvent.image;
        delete newEvent['image'];
        return $scope.events.push(newEvent);
      }, function(error) {
        return console.log(error);
      });
    };
    $scope.deleteEvent = function(event, index) {
      return eventResource.remove({
        id: event._id
      }, function(response) {
        return $scope.events.splice(index, 1);
      });
    };
    return $scope.put = function(form) {
      if (!form.$valid) {
        return this.event.showValidations = true;
      } else {
        this.event.showValidations = false;
        return eventResource.put({
          id: this.event._id
        }, this.event, (function(_this) {
          return function(response) {
            console.log(response);
            _this.event.imageUrl = response.image;
            return _this.event.title = _this.event.name;
          };
        })(this), function(error) {
          return console.log(error);
        });
      }
    };
  }).directive('longname', function() {
    return {
      require: 'ngModel',
      link: function(scope, elm, attrs, ctrl) {
        return ctrl.$validators.longname = function(modelVal, viewVal) {
          if (viewVal.length > 5) {
            return true;
          }
          return false;
        };
      }
    };
  });
};



},{}],11:[function(require,module,exports){
module.exports = function(app) {
  return app.controller('AdminFamilyController', function($scope, $location) {});
};



},{}],12:[function(require,module,exports){
module.exports = function(app) {
  return app.controller('AdminIndexController', function($scope, $location) {});
};



},{}],13:[function(require,module,exports){
module.exports = function(app) {
  var BlogController;
  return app.controller('BlogController', BlogController = (function() {
    function BlogController($scope, $rootScope, $http) {
      var blog1;
      this.$scope = $scope;
      this.$rootScope = $rootScope;
      this.$http = $http;
      this.$scope.date = new Date();
      blog1 = {
        name: 'bloggy',
        date: '05/50/5005',
        components: [
          {
            paragraph: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?",
            image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
          }, {
            paragraph: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?",
            image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
          }, {
            paragraph: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?",
            image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'
          }
        ]
      };
      this.$scope.blogs = [blog1];
    }

    BlogController.prototype.openLoginModal = function() {
      this.$scope.loginModal.modal('show');
    };

    BlogController.prototype.openSignupModal = function() {
      this.$scope.signupModal.modal('show');
    };

    BlogController.prototype.logout = function() {
      return this.$http.post(this.$rootScope.paths["public"].logout, {}).success((function(_this) {
        return function(res) {
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err;
        };
      })(this));
    };

    return BlogController;

  })());
};



},{}],14:[function(require,module,exports){
module.exports = function(app) {
  var CabinetController;
  return app.controller('CabinetController', CabinetController = (function() {
    function CabinetController($scope, $rootScope, $http) {
      var cabinet1;
      this.$scope = $scope;
      this.$rootScope = $rootScope;
      this.$http = $http;
      this.$scope.date = new Date();
      cabinet1 = {
        name: 'monkey',
        position: 'President',
        facts: ['fdasf', 'fdas', 'afds'],
        description: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or",
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg',
        hidden: 'http://i.usatoday.net/communitymanager/_photos/game-hunters/2012/01/04/hidden0104x-large.jpg'
      };
      this.$scope.cabinet = [cabinet1];
    }

    CabinetController.prototype.openLoginModal = function() {
      this.$scope.loginModal.modal('show');
    };

    CabinetController.prototype.openSignupModal = function() {
      this.$scope.signupModal.modal('show');
    };

    CabinetController.prototype.logout = function() {
      return this.$http.post(this.$rootScope.paths["public"].logout, {}).success((function(_this) {
        return function(res) {
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err;
        };
      })(this));
    };

    return CabinetController;

  })());
};



},{}],15:[function(require,module,exports){
module.exports = function(app) {
  var CommitteesController;
  return app.controller('CommitteesController', CommitteesController = (function() {
    function CommitteesController($scope, $rootScope, $http) {
      var com1, com2;
      this.$scope = $scope;
      this.$rootScope = $rootScope;
      this.$http = $http;
      this.$scope.date = new Date();
      com1 = {
        name: 'yolo',
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg',
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
      };
      com2 = {
        name: 'polo',
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg',
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
      };
      this.$scope.committees = [com1, com2];
    }

    CommitteesController.prototype.openLoginModal = function() {
      this.$scope.loginModal.modal('show');
    };

    CommitteesController.prototype.openSignupModal = function() {
      this.$scope.signupModal.modal('show');
    };

    CommitteesController.prototype.logout = function() {
      return this.$http.post(this.$rootScope.paths["public"].logout, {}).success((function(_this) {
        return function(res) {
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err;
        };
      })(this));
    };

    return CommitteesController;

  })());
};



},{}],16:[function(require,module,exports){
module.exports = function(app) {
  var EventsController;
  return app.controller('EventsController', EventsController = (function() {
    function EventsController($scope, $rootScope, $http) {
      var event1, event2;
      this.$scope = $scope;
      this.$rootScope = $rootScope;
      this.$http = $http;
      this.$scope.date = new Date();
      event1 = {
        name: 'yolo',
        date: '05/05/5050',
        location: 'sproul hall',
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg',
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
      };
      event2 = {
        name: 'polo',
        date: '05/05/5050',
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg',
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa'
      };
      this.$scope.events = [event1, event2];
    }

    EventsController.prototype.openLoginModal = function() {
      this.$scope.loginModal.modal('show');
    };

    EventsController.prototype.openSignupModal = function() {
      this.$scope.signupModal.modal('show');
    };

    EventsController.prototype.logout = function() {
      return this.$http.post(this.$rootScope.paths["public"].logout, {}).success((function(_this) {
        return function(res) {
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err;
        };
      })(this));
    };

    return EventsController;

  })());
};



},{}],17:[function(require,module,exports){
module.exports = function(app) {
  var FamiliesController;
  return app.controller('FamiliesController', FamiliesController = (function() {
    function FamiliesController($scope, $rootScope, $http) {
      var family1;
      this.$scope = $scope;
      this.$rootScope = $rootScope;
      this.$http = $http;
      this.$scope.date = new Date();
      family1 = {
        name: 'yolo',
        color: 'black',
        image: 'http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg',
        thumbnails: ['http://i.kinja-img.com/gawker-media/image/upload/s--636vKZQq--/c_fit,fl_progressive,q_80,w_636/oqcnwo41iea3wgaa8cfb.jpg'],
        description: 'fsakljfdsalk;fjdkaslfjd fsadklfl;dsa fjdsalkf jsadkl fksdalj faskj fsadj ;lfkasdjfkasdl;;l kassdfasfdsa',
        parents: [
          {
            name: 'Michelle',
            image: 'https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xpf1/v/t1.0-9/10998011_832611260117936_3932034622428075156_n.jpg?oh=b987692866bc2abb5f3898053001789c&oe=563D325E'
          }, {
            name: 'Kathy',
            image: 'https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/1606992_10205508009673423_7104651028651402931_n.jpg?oh=89eed60427f4951e517fafdb459e71fd&oe=564425C8'
          }, {
            name: 'Mitchie',
            image: 'https://scontent-sjc2-1.xx.fbcdn.net/hphotos-xft1/v/t1.0-9/11781810_1609731899295688_4598194794072730615_n.jpg?oh=2480c803a923c151cd47846972eda383&oe=5674E33D'
          }
        ]
      };
      this.$scope.families = [family1];
    }

    FamiliesController.prototype.openLoginModal = function() {
      this.$scope.loginModal.modal('show');
    };

    FamiliesController.prototype.openSignupModal = function() {
      this.$scope.signupModal.modal('show');
    };

    FamiliesController.prototype.logout = function() {
      return this.$http.post(this.$rootScope.paths["public"].logout, {}).success((function(_this) {
        return function(res) {
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err;
        };
      })(this));
    };

    return FamiliesController;

  })());
};



},{}],18:[function(require,module,exports){
module.exports = function(app) {
  var HomeController;
  return app.controller('HomeController', HomeController = (function() {
    function HomeController($scope, $http, $rootScope, $route) {
      this.$scope = $scope;
      this.$http = $http;
      this.$rootScope = $rootScope;
      this.$route = $route;
      this.$scope.date = new Date();
    }

    HomeController.prototype.openLoginModal = function() {
      this.$scope.loginModal.modal('show');
    };

    HomeController.prototype.openSignupModal = function() {
      this.$scope.signupModal.modal('show');
    };

    HomeController.prototype.logout = function() {
      return this.$http.post(this.$rootScope.paths["public"].logout, {}).success((function(_this) {
        return function(res) {
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err;
        };
      })(this));
    };

    return HomeController;

  })());
};



},{}],19:[function(require,module,exports){
module.exports = function(app) {
  return app.directive('longname', function() {
    return {
      require: 'ngModel',
      link: function(scope, elm, attrs, ctrl) {
        return ctrl.$validators.longname = function(modelVal, viewVal) {
          if (viewVal.length > 5) {
            return true;
          }
          return false;
        };
      }
    };
  }).directive('filesModel', function($parse) {
    return {
      link: function(scope, element, attrs) {
        var exp;
        exp = $parse(attrs.filesModel);
        return element.on('change', function() {
          exp.assign(scope, this.files);
          return scope.$apply;
        });
      }
    };
  });
};



},{}],20:[function(require,module,exports){
module.exports = function(app) {
  var LoginModal;
  app.directive('aaaLoginModal', function() {
    return {
      restrict: 'E',
      templateUrl: 'templates/login.html',
      link: function(scope, elem, attrs) {
        elem = elem.find('.ui.modal');
        scope.$parent.loginModal = elem;
        scope.loginModal = elem;
        return scope.loginModal.modal();
      },
      controller: LoginModal,
      controllerAs: 'self',
      scope: {}
    };
  });
  return LoginModal = (function() {
    function LoginModal($scope, $http, $rootScope, $route) {
      this.$scope = $scope;
      this.$http = $http;
      this.$rootScope = $rootScope;
      this.$route = $route;
    }

    LoginModal.prototype.open = function() {
      return this.$scope.loginModal.modal('show');
    };

    LoginModal.prototype.close = function() {
      return this.$scope.loginModal.modal('hide');
    };

    LoginModal.prototype.submit = function(form) {
      if (this.$scope.loading) {
        return;
      }
      this.$scope.loading = true;
      return this.$http.post(this.$rootScope.paths["public"].login, form).success((function(_this) {
        return function(res) {
          _this.close();
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err;
        };
      })(this))["finally"]((function(_this) {
        return function() {
          return delete _this.$scope.loading;
        };
      })(this));
    };

    return LoginModal;

  })();
};



},{}],21:[function(require,module,exports){
module.exports = function(app) {
  var SignupModal;
  app.directive('aaaSignupModal', function() {
    return {
      restrict: 'E',
      templateUrl: 'templates/signup.html',
      link: function(scope, elem, attrs) {
        elem = elem.find('.ui.modal');
        scope.$parent.signupModal = elem;
        scope.signupModal = elem;
        return scope.signupModal.modal();
      },
      controller: SignupModal,
      controllerAs: 'self',
      scope: {}
    };
  });
  return SignupModal = (function() {
    function SignupModal($scope, $http, $rootScope, $route) {
      this.$scope = $scope;
      this.$http = $http;
      this.$rootScope = $rootScope;
      this.$route = $route;
    }

    SignupModal.prototype.open = function() {
      return this.$scope.signupModal.modal('show');
    };

    SignupModal.prototype.close = function() {
      return this.$scope.signupModal.modal('hide');
    };

    SignupModal.prototype.submit = function(form) {
      if (this.$scope.loading) {
        return;
      }
      delete this.$scope.error;
      if (!this.validate(form)) {
        return;
      }
      this.$scope.loading = true;
      return this.$http.post(this.$rootScope.paths["public"].signup, form).success((function(_this) {
        return function(res) {
          _this.close();
          return location.reload();
        };
      })(this)).error((function(_this) {
        return function(err) {
          return _this.$scope.error = err.message || err || "Internal server error";
        };
      })(this))["finally"]((function(_this) {
        return function() {
          delete _this.$scope.loading;
        };
      })(this));
    };

    SignupModal.prototype.validate = function(form) {
      var errors;
      errors = [];
      if (!form.email) {
        errors.push("Email field left blank");
      }
      if (!/^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(form.email)) {
        errors.push("Invalid email address");
      }
      if (form.password.length < 8) {
        errors.push("Password must be at least 8 characters in length");
      }
      if (form.password !== form.confirm) {
        errors.push("Password and confirmation do not match");
      }
      if (errors.length) {
        this.$scope.error = errors;
      }
      return errors.length === 0;
    };

    return SignupModal;

  })();
};



},{}],22:[function(require,module,exports){
module.exports = function() {
  return angular.module('filters', []).filter('search', function() {
    return function(items, query) {
      if (query === '' || query === (void 0)) {
        return items;
      }
      return _.filter(items, function(item) {
        return (item.name.indexOf(query)) > -1;
      });
    };
  });
};



},{}],23:[function(require,module,exports){
module.exports = function() {
  return angular.module("eventsApiResource", []).service('eventsApi', function($resource) {
    var toMultipartForm;
    toMultipartForm = function(data, headersGetter) {
      var fd;
      if (data === void 0) {
        return data;
      }
      fd = new FormData;
      angular.forEach(data, function(value, key) {
        if (value instanceof FileList) {
          if (value.length === 1) {
            return fd.append(key, value[0]);
          } else {
            return angular.forEach(value, function(file, index) {
              return fd.append(key + '_' + index, file);
            });
          }
        } else {
          return fd.append(key, value);
        }
      });
      return fd;
    };
    return {
      events: function(eventsPath) {
        return $resource(eventsPath, '', {
          'create': {
            method: 'POST',
            isArray: false,
            url: eventsPath,
            headers: {
              'Content-Type': void 0
            },
            transformRequest: toMultipartForm,
            interceptor: {
              response: function(response) {
                console.log('DITME RESPONSE');
                console.log(response);
                return response;
              }
            }
          }
        });
      },
      event: function(eventPath) {
        return $resource(eventPath, {
          id: '@_id'
        }, {
          'put': {
            method: 'PUT',
            url: eventPath,
            isArray: false,
            headers: {
              'Content-Type': void 0
            },
            transformRequest: toMultipartForm
          }
        });
      }
    };
  });
};



},{}],24:[function(require,module,exports){
module.exports = function() {
  return angular.module("routeServices", []).service('routeTraverse', function($rootScope) {
    var paths;
    paths = $rootScope.paths;
    return {
      resolve: function(pathname) {
        var currentObject, item, returnPath, tree, _i, _len;
        returnPath = '';
        tree = pathname.split('.');
        currentObject = paths;
        for (_i = 0, _len = tree.length; _i < _len; _i++) {
          item = tree[_i];
          if (!currentObject) {
            return -1;
          }
          currentObject = currentObject[item];
          if (typeof currentObject === 'string') {
            returnPath += currentObject;
          } else if (currentObject['base']) {
            returnPath += currentObject['base'];
          } else {
            continue;
          }
        }
        console.log(returnPath);
        return returnPath;
      }
    };
  });
};



},{}]},{},[1]);
