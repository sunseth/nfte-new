(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
module.exports = {
  dashboard: {
    index: '/'
  }
};



},{}],2:[function(require,module,exports){
module.exports = {
  "public": require('./public'),
  admin: require('./admin'),
  forbidden: '403.ejs',
  notFound: '404.ejs'
};



},{"./admin":1,"./public":3}],3:[function(require,module,exports){
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
  }
};



},{}],4:[function(require,module,exports){
module.exports = function(app) {};



},{}],5:[function(require,module,exports){
module.exports = function(app) {};



},{}],6:[function(require,module,exports){
module.exports = function(app) {};



},{}],7:[function(require,module,exports){
module.exports = function(app) {};



},{}],8:[function(require,module,exports){
module.exports = function(app) {
  var HomeController;
  return app.controller('HomeController', HomeController = (function() {
    function HomeController($scope) {
      this.$scope = $scope;
      this.$scope.date = new Date();
    }

    HomeController.prototype.openLoginModal = function() {
      this.$scope.loginModal.modal('show');
    };

    HomeController.prototype.openSignupModal = function() {
      this.$scope.signupModal.modal('show');
    };

    return HomeController;

  })());
};



},{}],9:[function(require,module,exports){
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
    function LoginModal($scope, $http, $rootScope) {
      this.$scope = $scope;
      this.$http = $http;
      this.$rootScope = $rootScope;
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
      return this.$http.post(this.$rootScope.path["public"].login, form).success((function(_this) {
        return function(res) {
          return _this.close();
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



},{}],10:[function(require,module,exports){
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
    function SignupModal($scope, $http, $rootScope) {
      this.$scope = $scope;
      this.$http = $http;
      this.$rootScope = $rootScope;
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
          console.log(res);
          return _this.close();
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



},{}],11:[function(require,module,exports){
var app, paths;

paths = require('../../paths');

app = angular.module('aaa-website', []);

app.run(function($rootScope) {
  return $rootScope.paths = paths;
});

require('./directives/login')(app);

require('./directives/signup')(app);

require('./controllers/public/home')(app);

require('./controllers/public/events')(app);

require('./controllers/public/families')(app);

require('./controllers/public/cabinet')(app);

require('./controllers/public/blog')(app);



},{"../../paths":2,"./controllers/public/blog":4,"./controllers/public/cabinet":5,"./controllers/public/events":6,"./controllers/public/families":7,"./controllers/public/home":8,"./directives/login":9,"./directives/signup":10}]},{},[11]);
