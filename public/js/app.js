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
  middleware: {
    trustProxy: '127.0.0.1'
  },
  s3: {
    accountId: 'AKIAIHQARFMAXKSUXFMA',
    secretKey: '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',
    bucket: 'aaa-dev'
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
    },
    facebook: {
      clientId: '',
      clientSecret: ''
    },
    google: {
      clientId: '',
      clientSecret: ''
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
  home: {
    index: '/'
  },
  login: {
    index: '/login'
  },
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
  media: {
    index: '/media'
  }
};



},{}],7:[function(require,module,exports){
var config, paths;

module.exports = function(app, dependencies) {};

config = dependencies.config, paths = dependencies.paths;



},{}],8:[function(require,module,exports){
var config, paths;

module.exports = function(app, dependencies) {};

config = dependencies.config, paths = dependencies.paths;



},{}],9:[function(require,module,exports){
var config, paths;

module.exports = function(app, dependencies) {};

config = dependencies.config, paths = dependencies.paths;



},{}],10:[function(require,module,exports){
var config, paths;

module.exports = function(app, dependencies) {};

config = dependencies.config, paths = dependencies.paths;



},{}],11:[function(require,module,exports){
var config, paths;

module.exports = function(app, dependencies) {};

config = dependencies.config, paths = dependencies.paths;



},{}],12:[function(require,module,exports){
var app, config, dependencies, paths;

config = require('../../config');

paths = require('../../paths');

dependencies = {
  config: config,
  paths: paths
};

app = angular.module('aaa-website', []);

app.run(function($rootScope) {
  return $rootScope.paths = paths;
});

require('./controllers/home')(app, dependencies);

require('./controllers/events')(app, dependencies);

require('./controllers/families')(app, dependencies);

require('./controllers/cabinet')(app, dependencies);

require('./controllers/blog')(app, dependencies);



},{"../../config":1,"../../paths":6,"./controllers/blog":7,"./controllers/cabinet":8,"./controllers/events":9,"./controllers/families":10,"./controllers/home":11}]},{},[12]);
