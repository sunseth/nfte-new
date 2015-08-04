(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function (process){
var env, extend, privateConf, publicConf;

extend = require('extend');

env = process.env.NODE_ENV || 'development';

publicConf = require('./public');

privateConf = require('./private');

module.exports = extend(true, {}, publicConf, privateConf);



}).call(this,require('_process'))
},{"./private":2,"./public":3,"_process":4,"extend":5}],2:[function(require,module,exports){
(function (process){
var base, config, env, extend;

extend = require('extend');

env = process.env.NODE_ENV || 'development';

base = {
  mongo: {
    uri: 'mongodb://localhost:27017/aaa',
    options: {
      server: {
        socketOptions: {
          keepAlive: 1,
          connectTimeoutMS: 60000
        }
      }
    }
  },
  redis: {
    port: 6379,
    host: 'localhost',
    secret: '162FzhDGCJ5lrprE37H4cRa8nu5em4eW',
    db: 1
  },
  middleware: {
    trustProxy: '127.0.0.1'
  },
  s3: {
    accountId: 'AKIAIHQARFMAXKSUXFMA',
    secretKey: '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',
    bucket: 'aaa-dev'
  },
  facebook: {
    clientId: '',
    clientSecret: ''
  },
  google: {
    clientId: '',
    clientSecret: ''
  }
};

config = {
  development: extend(true, {}, base),
  test: extend(true, {}, base, {
    mongo: {
      uri: 'mongodb://localhost:27017/test'
    }
  }),
  stage: extend(true, {}, base, {
    mongo: {
      uri: 'aaa.sethsun.com/aaa'
    }
  }),
  production: extend(true, {}, base, {
    mongo: {
      uri: 'mongodb://localhost:27017/primary',
      options: {
        replset: {
          rs_name: 'rs0',
          socketOptions: {
            keepAlive: 1,
            connectTimeoutMS: 30000
          }
        }
      }
    },
    s3: {
      accountId: 'AKIAIHQARFMAXKSUXFMA',
      secretKey: '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',
      bucket: 'aaa-prod'
    }
  })
};

module.exports = config[env] || {};

module.exports.env = env;



}).call(this,require('_process'))
},{"_process":4,"extend":5}],3:[function(require,module,exports){
(function (process){
var base, config, env, extend;

extend = require('extend');

env = process.env.NODE_ENV || 'development';

base = {
  home: {
    port: 8080,
    externalPort: 80
  },
  analytics: {
    google: {
      id: ''
    }
  }
};

config = {
  development: extend(true, {}, base, {
    home: {
      externalPort: 8080
    }
  }),
  test: extend(true, {}, base),
  stage: extend(true, {}, base, {
    home: {
      host: 'aaa.sethsun.com',
      protocol: 'http'
    }
  }),
  production: extend(true, {}, base, {
    home: {
      port: 8080,
      host: 'aaaberkeley.com',
      protocol: 'http'
    }
  })
};

module.exports = config[env] || {};

module.exports.env = env;



}).call(this,require('_process'))
},{"_process":4,"extend":5}],4:[function(require,module,exports){
// shim for using process in browser

var process = module.exports = {};

process.nextTick = (function () {
    var canSetImmediate = typeof window !== 'undefined'
    && window.setImmediate;
    var canMutationObserver = typeof window !== 'undefined'
    && window.MutationObserver;
    var canPost = typeof window !== 'undefined'
    && window.postMessage && window.addEventListener
    ;

    if (canSetImmediate) {
        return function (f) { return window.setImmediate(f) };
    }

    var queue = [];

    if (canMutationObserver) {
        var hiddenDiv = document.createElement("div");
        var observer = new MutationObserver(function () {
            var queueList = queue.slice();
            queue.length = 0;
            queueList.forEach(function (fn) {
                fn();
            });
        });

        observer.observe(hiddenDiv, { attributes: true });

        return function nextTick(fn) {
            if (!queue.length) {
                hiddenDiv.setAttribute('yes', 'no');
            }
            queue.push(fn);
        };
    }

    if (canPost) {
        window.addEventListener('message', function (ev) {
            var source = ev.source;
            if ((source === window || source === null) && ev.data === 'process-tick') {
                ev.stopPropagation();
                if (queue.length > 0) {
                    var fn = queue.shift();
                    fn();
                }
            }
        }, true);

        return function nextTick(fn) {
            queue.push(fn);
            window.postMessage('process-tick', '*');
        };
    }

    return function nextTick(fn) {
        setTimeout(fn, 0);
    };
})();

process.title = 'browser';
process.browser = true;
process.env = {};
process.argv = [];

function noop() {}

process.on = noop;
process.addListener = noop;
process.once = noop;
process.off = noop;
process.removeListener = noop;
process.removeAllListeners = noop;
process.emit = noop;

process.binding = function (name) {
    throw new Error('process.binding is not supported');
};

// TODO(shtylman)
process.cwd = function () { return '/' };
process.chdir = function (dir) {
    throw new Error('process.chdir is not supported');
};

},{}],5:[function(require,module,exports){
'use strict';

var hasOwn = Object.prototype.hasOwnProperty;
var toStr = Object.prototype.toString;

var isArray = function isArray(arr) {
	if (typeof Array.isArray === 'function') {
		return Array.isArray(arr);
	}

	return toStr.call(arr) === '[object Array]';
};

var isPlainObject = function isPlainObject(obj) {
	if (!obj || toStr.call(obj) !== '[object Object]') {
		return false;
	}

	var hasOwnConstructor = hasOwn.call(obj, 'constructor');
	var hasIsPrototypeOf = obj.constructor && obj.constructor.prototype && hasOwn.call(obj.constructor.prototype, 'isPrototypeOf');
	// Not own constructor property must be Object
	if (obj.constructor && !hasOwnConstructor && !hasIsPrototypeOf) {
		return false;
	}

	// Own properties are enumerated firstly, so to speed up,
	// if last one is own, then all properties are own.
	var key;
	for (key in obj) {/**/}

	return typeof key === 'undefined' || hasOwn.call(obj, key);
};

module.exports = function extend() {
	var options, name, src, copy, copyIsArray, clone,
		target = arguments[0],
		i = 1,
		length = arguments.length,
		deep = false;

	// Handle a deep copy situation
	if (typeof target === 'boolean') {
		deep = target;
		target = arguments[1] || {};
		// skip the boolean and the target
		i = 2;
	} else if ((typeof target !== 'object' && typeof target !== 'function') || target == null) {
		target = {};
	}

	for (; i < length; ++i) {
		options = arguments[i];
		// Only deal with non-null/undefined values
		if (options != null) {
			// Extend the base object
			for (name in options) {
				src = target[name];
				copy = options[name];

				// Prevent never-ending loop
				if (target !== copy) {
					// Recurse if we're merging plain objects or arrays
					if (deep && copy && (isPlainObject(copy) || (copyIsArray = isArray(copy)))) {
						if (copyIsArray) {
							copyIsArray = false;
							clone = src && isArray(src) ? src : [];
						} else {
							clone = src && isPlainObject(src) ? src : {};
						}

						// Never move original objects, clone them
						target[name] = extend(deep, clone, copy);

					// Don't bring in undefined values
					} else if (typeof copy !== 'undefined') {
						target[name] = copy;
					}
				}
			}
		}
	}

	// Return the modified object
	return target;
};


},{}],6:[function(require,module,exports){
module.exports = {
  dashboard: {
    index: '/'
  }
};



},{}],7:[function(require,module,exports){
module.exports = {
  "public": require('./public'),
  admin: require('./admin'),
  forbidden: '403.ejs',
  notFound: '404.ejs'
};



},{"./admin":6,"./public":8}],8:[function(require,module,exports){
module.exports = {
  home: {
    index: '/'
  },
  login: '/login',
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



},{}],9:[function(require,module,exports){
module.exports = function(app) {};



},{}],10:[function(require,module,exports){
module.exports = function(app) {};



},{}],11:[function(require,module,exports){
module.exports = function(app) {};



},{}],12:[function(require,module,exports){
module.exports = function(app) {};



},{}],13:[function(require,module,exports){
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



},{}],14:[function(require,module,exports){
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



},{}],15:[function(require,module,exports){
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



},{}],16:[function(require,module,exports){
var app, config, paths;

config = require('../../config');

paths = require('../../paths');

app = angular.module('aaa-website', []);

app.run(function($rootScope) {
  $rootScope.paths = paths;
  return $rootScope.config = config;
});

require('./directives/login')(app);

require('./directives/signup')(app);

require('./controllers/public/home')(app);

require('./controllers/public/events')(app);

require('./controllers/public/families')(app);

require('./controllers/public/cabinet')(app);

require('./controllers/public/blog')(app);



},{"../../config":1,"../../paths":7,"./controllers/public/blog":9,"./controllers/public/cabinet":10,"./controllers/public/events":11,"./controllers/public/families":12,"./controllers/public/home":13,"./directives/login":14,"./directives/signup":15}]},{},[16]);
