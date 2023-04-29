/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 4);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

/* globals __VUE_SSR_CONTEXT__ */

// IMPORTANT: Do NOT use ES2015 features in this file.
// This module is a runtime utility for cleaner component module output and will
// be included in the final webpack user bundle.

module.exports = function normalizeComponent (
  rawScriptExports,
  compiledTemplate,
  functionalTemplate,
  injectStyles,
  scopeId,
  moduleIdentifier /* server only */
) {
  var esModule
  var scriptExports = rawScriptExports = rawScriptExports || {}

  // ES6 modules interop
  var type = typeof rawScriptExports.default
  if (type === 'object' || type === 'function') {
    esModule = rawScriptExports
    scriptExports = rawScriptExports.default
  }

  // Vue.extend constructor export interop
  var options = typeof scriptExports === 'function'
    ? scriptExports.options
    : scriptExports

  // render functions
  if (compiledTemplate) {
    options.render = compiledTemplate.render
    options.staticRenderFns = compiledTemplate.staticRenderFns
    options._compiled = true
  }

  // functional template
  if (functionalTemplate) {
    options.functional = true
  }

  // scopedId
  if (scopeId) {
    options._scopeId = scopeId
  }

  var hook
  if (moduleIdentifier) { // server build
    hook = function (context) {
      // 2.3 injection
      context =
        context || // cached call
        (this.$vnode && this.$vnode.ssrContext) || // stateful
        (this.parent && this.parent.$vnode && this.parent.$vnode.ssrContext) // functional
      // 2.2 with runInNewContext: true
      if (!context && typeof __VUE_SSR_CONTEXT__ !== 'undefined') {
        context = __VUE_SSR_CONTEXT__
      }
      // inject component styles
      if (injectStyles) {
        injectStyles.call(this, context)
      }
      // register component module identifier for async chunk inferrence
      if (context && context._registeredComponents) {
        context._registeredComponents.add(moduleIdentifier)
      }
    }
    // used by ssr in case component is cached and beforeCreate
    // never gets called
    options._ssrRegister = hook
  } else if (injectStyles) {
    hook = injectStyles
  }

  if (hook) {
    var functional = options.functional
    var existing = functional
      ? options.render
      : options.beforeCreate

    if (!functional) {
      // inject component registration as beforeCreate hook
      options.beforeCreate = existing
        ? [].concat(existing, hook)
        : [hook]
    } else {
      // for template-only hot-reload because in that case the render fn doesn't
      // go through the normalizer
      options._injectStyles = hook
      // register for functioal component in vue file
      options.render = function renderWithStyleInjection (h, context) {
        hook.call(context)
        return existing(h, context)
      }
    }
  }

  return {
    esModule: esModule,
    exports: scriptExports,
    options: options
  }
}


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

var disposed = false
function injectStyle (ssrContext) {
  if (disposed) return
  __webpack_require__(15)
}
var normalizeComponent = __webpack_require__(0)
/* script */
var __vue_script__ = __webpack_require__(17)
/* template */
var __vue_template__ = __webpack_require__(18)
/* template functional */
var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __vue_script__,
  __vue_template__,
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "resources/js/components/Modal.vue"

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-53ab54d2", Component.options)
  } else {
    hotAPI.reload("data-v-53ab54d2", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

module.exports = Component.exports


/***/ }),
/* 2 */
/***/ (function(module, exports) {

/*
	MIT License http://www.opensource.org/licenses/mit-license.php
	Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
module.exports = function(useSourceMap) {
	var list = [];

	// return the list of modules as css string
	list.toString = function toString() {
		return this.map(function (item) {
			var content = cssWithMappingToString(item, useSourceMap);
			if(item[2]) {
				return "@media " + item[2] + "{" + content + "}";
			} else {
				return content;
			}
		}).join("");
	};

	// import a list of modules into the list
	list.i = function(modules, mediaQuery) {
		if(typeof modules === "string")
			modules = [[null, modules, ""]];
		var alreadyImportedModules = {};
		for(var i = 0; i < this.length; i++) {
			var id = this[i][0];
			if(typeof id === "number")
				alreadyImportedModules[id] = true;
		}
		for(i = 0; i < modules.length; i++) {
			var item = modules[i];
			// skip already imported module
			// this implementation is not 100% perfect for weird media query combinations
			//  when a module is imported multiple times with different media queries.
			//  I hope this will never occur (Hey this way we have smaller bundles)
			if(typeof item[0] !== "number" || !alreadyImportedModules[item[0]]) {
				if(mediaQuery && !item[2]) {
					item[2] = mediaQuery;
				} else if(mediaQuery) {
					item[2] = "(" + item[2] + ") and (" + mediaQuery + ")";
				}
				list.push(item);
			}
		}
	};
	return list;
};

function cssWithMappingToString(item, useSourceMap) {
	var content = item[1] || '';
	var cssMapping = item[3];
	if (!cssMapping) {
		return content;
	}

	if (useSourceMap && typeof btoa === 'function') {
		var sourceMapping = toComment(cssMapping);
		var sourceURLs = cssMapping.sources.map(function (source) {
			return '/*# sourceURL=' + cssMapping.sourceRoot + source + ' */'
		});

		return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
	}

	return [content].join('\n');
}

// Adapted from convert-source-map (MIT)
function toComment(sourceMap) {
	// eslint-disable-next-line no-undef
	var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap))));
	var data = 'sourceMappingURL=data:application/json;charset=utf-8;base64,' + base64;

	return '/*# ' + data + ' */';
}


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Author Tobias Koppers @sokra
  Modified by Evan You @yyx990803
*/

var hasDocument = typeof document !== 'undefined'

if (typeof DEBUG !== 'undefined' && DEBUG) {
  if (!hasDocument) {
    throw new Error(
    'vue-style-loader cannot be used in a non-browser environment. ' +
    "Use { target: 'node' } in your Webpack config to indicate a server-rendering environment."
  ) }
}

var listToStyles = __webpack_require__(10)

/*
type StyleObject = {
  id: number;
  parts: Array<StyleObjectPart>
}

type StyleObjectPart = {
  css: string;
  media: string;
  sourceMap: ?string
}
*/

var stylesInDom = {/*
  [id: number]: {
    id: number,
    refs: number,
    parts: Array<(obj?: StyleObjectPart) => void>
  }
*/}

var head = hasDocument && (document.head || document.getElementsByTagName('head')[0])
var singletonElement = null
var singletonCounter = 0
var isProduction = false
var noop = function () {}
var options = null
var ssrIdKey = 'data-vue-ssr-id'

// Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
// tags it will allow on a page
var isOldIE = typeof navigator !== 'undefined' && /msie [6-9]\b/.test(navigator.userAgent.toLowerCase())

module.exports = function (parentId, list, _isProduction, _options) {
  isProduction = _isProduction

  options = _options || {}

  var styles = listToStyles(parentId, list)
  addStylesToDom(styles)

  return function update (newList) {
    var mayRemove = []
    for (var i = 0; i < styles.length; i++) {
      var item = styles[i]
      var domStyle = stylesInDom[item.id]
      domStyle.refs--
      mayRemove.push(domStyle)
    }
    if (newList) {
      styles = listToStyles(parentId, newList)
      addStylesToDom(styles)
    } else {
      styles = []
    }
    for (var i = 0; i < mayRemove.length; i++) {
      var domStyle = mayRemove[i]
      if (domStyle.refs === 0) {
        for (var j = 0; j < domStyle.parts.length; j++) {
          domStyle.parts[j]()
        }
        delete stylesInDom[domStyle.id]
      }
    }
  }
}

function addStylesToDom (styles /* Array<StyleObject> */) {
  for (var i = 0; i < styles.length; i++) {
    var item = styles[i]
    var domStyle = stylesInDom[item.id]
    if (domStyle) {
      domStyle.refs++
      for (var j = 0; j < domStyle.parts.length; j++) {
        domStyle.parts[j](item.parts[j])
      }
      for (; j < item.parts.length; j++) {
        domStyle.parts.push(addStyle(item.parts[j]))
      }
      if (domStyle.parts.length > item.parts.length) {
        domStyle.parts.length = item.parts.length
      }
    } else {
      var parts = []
      for (var j = 0; j < item.parts.length; j++) {
        parts.push(addStyle(item.parts[j]))
      }
      stylesInDom[item.id] = { id: item.id, refs: 1, parts: parts }
    }
  }
}

function createStyleElement () {
  var styleElement = document.createElement('style')
  styleElement.type = 'text/css'
  head.appendChild(styleElement)
  return styleElement
}

function addStyle (obj /* StyleObjectPart */) {
  var update, remove
  var styleElement = document.querySelector('style[' + ssrIdKey + '~="' + obj.id + '"]')

  if (styleElement) {
    if (isProduction) {
      // has SSR styles and in production mode.
      // simply do nothing.
      return noop
    } else {
      // has SSR styles but in dev mode.
      // for some reason Chrome can't handle source map in server-rendered
      // style tags - source maps in <style> only works if the style tag is
      // created and inserted dynamically. So we remove the server rendered
      // styles and inject new ones.
      styleElement.parentNode.removeChild(styleElement)
    }
  }

  if (isOldIE) {
    // use singleton mode for IE9.
    var styleIndex = singletonCounter++
    styleElement = singletonElement || (singletonElement = createStyleElement())
    update = applyToSingletonTag.bind(null, styleElement, styleIndex, false)
    remove = applyToSingletonTag.bind(null, styleElement, styleIndex, true)
  } else {
    // use multi-style-tag mode in all other cases
    styleElement = createStyleElement()
    update = applyToTag.bind(null, styleElement)
    remove = function () {
      styleElement.parentNode.removeChild(styleElement)
    }
  }

  update(obj)

  return function updateStyle (newObj /* StyleObjectPart */) {
    if (newObj) {
      if (newObj.css === obj.css &&
          newObj.media === obj.media &&
          newObj.sourceMap === obj.sourceMap) {
        return
      }
      update(obj = newObj)
    } else {
      remove()
    }
  }
}

var replaceText = (function () {
  var textStore = []

  return function (index, replacement) {
    textStore[index] = replacement
    return textStore.filter(Boolean).join('\n')
  }
})()

function applyToSingletonTag (styleElement, index, remove, obj) {
  var css = remove ? '' : obj.css

  if (styleElement.styleSheet) {
    styleElement.styleSheet.cssText = replaceText(index, css)
  } else {
    var cssNode = document.createTextNode(css)
    var childNodes = styleElement.childNodes
    if (childNodes[index]) styleElement.removeChild(childNodes[index])
    if (childNodes.length) {
      styleElement.insertBefore(cssNode, childNodes[index])
    } else {
      styleElement.appendChild(cssNode)
    }
  }
}

function applyToTag (styleElement, obj) {
  var css = obj.css
  var media = obj.media
  var sourceMap = obj.sourceMap

  if (media) {
    styleElement.setAttribute('media', media)
  }
  if (options.ssrId) {
    styleElement.setAttribute(ssrIdKey, obj.id)
  }

  if (sourceMap) {
    // https://developer.chrome.com/devtools/docs/javascript-debugging
    // this makes source maps inside style tags work properly in Chrome
    css += '\n/*# sourceURL=' + sourceMap.sources[0] + ' */'
    // http://stackoverflow.com/a/26603875
    css += '\n/*# sourceMappingURL=data:application/json;base64,' + btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))) + ' */'
  }

  if (styleElement.styleSheet) {
    styleElement.styleSheet.cssText = css
  } else {
    while (styleElement.firstChild) {
      styleElement.removeChild(styleElement.firstChild)
    }
    styleElement.appendChild(document.createTextNode(css))
  }
}


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__(5);
module.exports = __webpack_require__(26);


/***/ }),
/* 5 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_vue_reactive_refs__ = __webpack_require__(6);


Nova.booting(function (Vue, router, store) {
    router.addRoutes([{
        name: "indicator-updater",
        path: "/indicator-updater",
        component: __webpack_require__(7)
    }]);

    Vue.use(__WEBPACK_IMPORTED_MODULE_0_vue_reactive_refs__["a" /* ReactiveRefs */]);
});

/***/ }),
/* 6 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* unused harmony export DynamicReactiveRefs */
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ReactiveRefs; });
/*!
  * vue-reactive-refs v0.0.2
  * (c) 2019 Eduardo San Martin Morote
  * @license MIT
  */
var ReactiveRefs = function (_Vue) {
    _Vue.mixin({
        beforeCreate: function () {
            var refs = this.$options.refs;
            if (!refs)
                return;
            // @ts-ignore
            this.$refs = _Vue.observable(refs.reduce(function ($refs, key) {
                $refs[key] = undefined;
                return $refs;
            }, {}));
        },
    });
};

/**
 * Because this version uses a Proxy, it will fail on any browser that does not
 * support it
 */
var DynamicReactiveRefs = function (_Vue) {
    _Vue.mixin({
        beforeCreate: function () {
            var $refs = _Vue.observable({});
            // @ts-ignore
            this.$refs = new Proxy($refs, {
                set: function (target, key, value) {
                    if (!(key in target))
                        _Vue.set($refs, key, value);
                    return Reflect.set(target, key, value);
                },
                get: function (target, key) {
                    if (!(key in target))
                        _Vue.set($refs, key, undefined);
                    return Reflect.get(target, key);
                },
            });
        },
    });
};




/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

var disposed = false
function injectStyle (ssrContext) {
  if (disposed) return
  __webpack_require__(8)
}
var normalizeComponent = __webpack_require__(0)
/* script */
var __vue_script__ = __webpack_require__(11)
/* template */
var __vue_template__ = __webpack_require__(25)
/* template functional */
var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __vue_script__,
  __vue_template__,
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "resources/js/components/Tool.vue"

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-68ff5483", Component.options)
  } else {
    hotAPI.reload("data-v-68ff5483", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

module.exports = Component.exports


/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(9);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
// add the styles to the DOM
var update = __webpack_require__(3)("290c3e45", content, false, {});
// Hot Module Replacement
if(false) {
 // When the styles change, update the <style> tags
 if(!content.locals) {
   module.hot.accept("!!../../../node_modules/css-loader/index.js!../../../node_modules/vue-loader/lib/style-compiler/index.js?{\"vue\":true,\"id\":\"data-v-68ff5483\",\"scoped\":false,\"hasInlineConfig\":true}!../../../node_modules/vue-loader/lib/selector.js?type=styles&index=0!./Tool.vue", function() {
     var newContent = require("!!../../../node_modules/css-loader/index.js!../../../node_modules/vue-loader/lib/style-compiler/index.js?{\"vue\":true,\"id\":\"data-v-68ff5483\",\"scoped\":false,\"hasInlineConfig\":true}!../../../node_modules/vue-loader/lib/selector.js?type=styles&index=0!./Tool.vue");
     if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
     update(newContent);
   });
 }
 // When the module is disposed, remove the <style> tags
 module.hot.dispose(function() { update(); });
}

/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(2)(false);
// imports


// module
exports.push([module.i, "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n/* Scoped Styles */\n", ""]);

// exports


/***/ }),
/* 10 */
/***/ (function(module, exports) {

/**
 * Translates the list format produced by css-loader into something
 * easier to manipulate.
 */
module.exports = function listToStyles (parentId, list) {
  var styles = []
  var newStyles = {}
  for (var i = 0; i < list.length; i++) {
    var item = list[i]
    var id = item[0]
    var css = item[1]
    var media = item[2]
    var sourceMap = item[3]
    var part = {
      id: parentId + ':' + i,
      css: css,
      media: media,
      sourceMap: sourceMap
    }
    if (!newStyles[id]) {
      styles.push(newStyles[id] = { id: id, parts: [part] })
    } else {
      newStyles[id].parts.push(part)
    }
  }
  return styles
}


/***/ }),
/* 11 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_babel_runtime_regenerator__ = __webpack_require__(12);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_babel_runtime_regenerator___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_babel_runtime_regenerator__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__Modal__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__Modal___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__Modal__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__GameSettings__ = __webpack_require__(19);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__GameSettings___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2__GameSettings__);


function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//



/* harmony default export */ __webpack_exports__["default"] = ({
    metaInfo: function metaInfo() {
        return {
            title: "IndicatorUpdater"
        };
    },

    components: { Modal: __WEBPACK_IMPORTED_MODULE_1__Modal___default.a, GameSettings: __WEBPACK_IMPORTED_MODULE_2__GameSettings___default.a },
    data: function data() {
        return {
            page_index: 'indicators',

            indicators: [],
            selected_indicator: null,

            entreprises: [],
            selected_entreprises: [],

            operations: [{ 'key': 'replace', 'name': 'Remplacer' }, { 'key': 'add', 'name': 'Ajouter' }, { 'key': 'mult', 'name': 'Multiplier' }, { 'key': 'reset', 'name': 'Réinitialiser' }],
            selected_operation: 'replace',
            operation_value: 0,

            indicator_2_loaded: false,
            selected_indicator_2: null,
            data: [],

            show_confirmation_modal: false,
            update_indicators_sent: false,

            settings: [],
            selected_setting: null,

            scenarios: ['Changement climatique', 'Un post d’un influenceur', 'Reglement RH', 'Tremblement de terre -Turquie-', 'Les repercusions de la guerre', 'Les crises geopolitiques , la chine et leconomie mondiale'],  //agg
            selected_scenario: 'Changement climatique', // agg

            show_reset_game_modal: false,
            reset_game_sent: false,

            show_change_scenario_modal: false,
            change_scenario_scent: false,

            password: '',
            correct_password: 'moncef_somnef_iec'
        };
    },

    methods: {
        getIndicators: function () {
            var _ref = _asyncToGenerator( /*#__PURE__*/__WEBPACK_IMPORTED_MODULE_0_babel_runtime_regenerator___default.a.mark(function _callee() {
                var _ref2, data;

                return __WEBPACK_IMPORTED_MODULE_0_babel_runtime_regenerator___default.a.wrap(function _callee$(_context) {
                    while (1) {
                        switch (_context.prev = _context.next) {
                            case 0:
                                _context.next = 2;
                                return Nova.request().get("/nova-vendor/indicator-updater/indicators");

                            case 2:
                                _ref2 = _context.sent;
                                data = _ref2.data;

                                this.indicators = data["indicators"];
                                this.entreprises = data["entreprises"];

                            case 6:
                            case "end":
                                return _context.stop();
                        }
                    }
                }, _callee, this);
            }));

            function getIndicators() {
                return _ref.apply(this, arguments);
            }

            return getIndicators;
        }(),
        update_indicator: function update_indicator() {
            var _this = this;

            var req = {
                entreprise_ids: this.selected_entreprises,
                selected_indicator: this.selected_indicator,
                selected_operation: this.selected_operation,
                value: this.operation_value
            };

            this.uncheckAllEntrep();
            this.selected_indicator = null;
            this.selected_operation = 'replace';
            this.operation_value = 0;

            this.show_confirmation_modal = false;
            this.update_indicators_sent = true;

            Nova.request().post("/nova-vendor/indicator-updater/update-indicator", req).then(function (_ref3) {
                var resp = _ref3.resp;

                _this.update_indicators_sent = false;
            });
        },
        getEntrepriseIndicators: function getEntrepriseIndicators() {
            var _this2 = this;

            Nova.request().post("/nova-vendor/indicator-updater/entreprise-indicators", {
                indicator_id: this.selected_indicator_2
            }).then(function (_ref4) {
                var data = _ref4.data;

                _this2.data = data;
                _this2.indicator_2_loaded = true;
            });
        },
        checkAllEntrep: function checkAllEntrep() {
            this.selected_entreprises = this.entreprises.map(function (x) {
                return x.id;
            });
        },
        uncheckAllEntrep: function uncheckAllEntrep() {
            this.selected_entreprises = [];
        },
        resetGame: function resetGame() {
            var _this3 = this;

            this.reset_game_sent = true;
            this.password = '';
            Nova.request().post('/nova-vendor/indicator-updater/reset-game', {}).then(function (_ref5) {
                var data = _ref5.data;

                _this3.show_reset_game_modal = false;
                _this3.reset_game_sent = false;
            });
        },
        changeScenario: function changeScenario() {
            var _this4 = this;

            this.change_scenario_sent = true;
            this.password = '';
            Nova.request().post('/nova-vendor/indicator-updater/change-scenario', {
                scenario: this.selected_scenario
            }).then(function (_ref6) {
                var data = _ref6.data;

                _this4.show_change_scenario_modal = false;
                _this4.change_scenario_sent = false;
            });
        }
    },

    watch: {},

    mounted: function () {
        var _ref7 = _asyncToGenerator( /*#__PURE__*/__WEBPACK_IMPORTED_MODULE_0_babel_runtime_regenerator___default.a.mark(function _callee2() {
            return __WEBPACK_IMPORTED_MODULE_0_babel_runtime_regenerator___default.a.wrap(function _callee2$(_context2) {
                while (1) {
                    switch (_context2.prev = _context2.next) {
                        case 0:
                            _context2.next = 2;
                            return this.getIndicators();

                        case 2:
                        case "end":
                            return _context2.stop();
                    }
                }
            }, _callee2, this);
        }));

        function mounted() {
            return _ref7.apply(this, arguments);
        }

        return mounted;
    }()
});

/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(13);


/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

/**
 * Copyright (c) 2014-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

// This method of obtaining a reference to the global object needs to be
// kept identical to the way it is obtained in runtime.js
var g = (function() { return this })() || Function("return this")();

// Use `getOwnPropertyNames` because not all browsers support calling
// `hasOwnProperty` on the global `self` object in a worker. See #183.
var hadRuntime = g.regeneratorRuntime &&
  Object.getOwnPropertyNames(g).indexOf("regeneratorRuntime") >= 0;

// Save the old regeneratorRuntime in case it needs to be restored later.
var oldRuntime = hadRuntime && g.regeneratorRuntime;

// Force reevalutation of runtime.js.
g.regeneratorRuntime = undefined;

module.exports = __webpack_require__(14);

if (hadRuntime) {
  // Restore the original runtime.
  g.regeneratorRuntime = oldRuntime;
} else {
  // Remove the global property added by runtime.js.
  try {
    delete g.regeneratorRuntime;
  } catch(e) {
    g.regeneratorRuntime = undefined;
  }
}


/***/ }),
/* 14 */
/***/ (function(module, exports) {

/**
 * Copyright (c) 2014-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

!(function(global) {
  "use strict";

  var Op = Object.prototype;
  var hasOwn = Op.hasOwnProperty;
  var undefined; // More compressible than void 0.
  var $Symbol = typeof Symbol === "function" ? Symbol : {};
  var iteratorSymbol = $Symbol.iterator || "@@iterator";
  var asyncIteratorSymbol = $Symbol.asyncIterator || "@@asyncIterator";
  var toStringTagSymbol = $Symbol.toStringTag || "@@toStringTag";

  var inModule = typeof module === "object";
  var runtime = global.regeneratorRuntime;
  if (runtime) {
    if (inModule) {
      // If regeneratorRuntime is defined globally and we're in a module,
      // make the exports object identical to regeneratorRuntime.
      module.exports = runtime;
    }
    // Don't bother evaluating the rest of this file if the runtime was
    // already defined globally.
    return;
  }

  // Define the runtime globally (as expected by generated code) as either
  // module.exports (if we're in a module) or a new, empty object.
  runtime = global.regeneratorRuntime = inModule ? module.exports : {};

  function wrap(innerFn, outerFn, self, tryLocsList) {
    // If outerFn provided and outerFn.prototype is a Generator, then outerFn.prototype instanceof Generator.
    var protoGenerator = outerFn && outerFn.prototype instanceof Generator ? outerFn : Generator;
    var generator = Object.create(protoGenerator.prototype);
    var context = new Context(tryLocsList || []);

    // The ._invoke method unifies the implementations of the .next,
    // .throw, and .return methods.
    generator._invoke = makeInvokeMethod(innerFn, self, context);

    return generator;
  }
  runtime.wrap = wrap;

  // Try/catch helper to minimize deoptimizations. Returns a completion
  // record like context.tryEntries[i].completion. This interface could
  // have been (and was previously) designed to take a closure to be
  // invoked without arguments, but in all the cases we care about we
  // already have an existing method we want to call, so there's no need
  // to create a new function object. We can even get away with assuming
  // the method takes exactly one argument, since that happens to be true
  // in every case, so we don't have to touch the arguments object. The
  // only additional allocation required is the completion record, which
  // has a stable shape and so hopefully should be cheap to allocate.
  function tryCatch(fn, obj, arg) {
    try {
      return { type: "normal", arg: fn.call(obj, arg) };
    } catch (err) {
      return { type: "throw", arg: err };
    }
  }

  var GenStateSuspendedStart = "suspendedStart";
  var GenStateSuspendedYield = "suspendedYield";
  var GenStateExecuting = "executing";
  var GenStateCompleted = "completed";

  // Returning this object from the innerFn has the same effect as
  // breaking out of the dispatch switch statement.
  var ContinueSentinel = {};

  // Dummy constructor functions that we use as the .constructor and
  // .constructor.prototype properties for functions that return Generator
  // objects. For full spec compliance, you may wish to configure your
  // minifier not to mangle the names of these two functions.
  function Generator() {}
  function GeneratorFunction() {}
  function GeneratorFunctionPrototype() {}

  // This is a polyfill for %IteratorPrototype% for environments that
  // don't natively support it.
  var IteratorPrototype = {};
  IteratorPrototype[iteratorSymbol] = function () {
    return this;
  };

  var getProto = Object.getPrototypeOf;
  var NativeIteratorPrototype = getProto && getProto(getProto(values([])));
  if (NativeIteratorPrototype &&
      NativeIteratorPrototype !== Op &&
      hasOwn.call(NativeIteratorPrototype, iteratorSymbol)) {
    // This environment has a native %IteratorPrototype%; use it instead
    // of the polyfill.
    IteratorPrototype = NativeIteratorPrototype;
  }

  var Gp = GeneratorFunctionPrototype.prototype =
    Generator.prototype = Object.create(IteratorPrototype);
  GeneratorFunction.prototype = Gp.constructor = GeneratorFunctionPrototype;
  GeneratorFunctionPrototype.constructor = GeneratorFunction;
  GeneratorFunctionPrototype[toStringTagSymbol] =
    GeneratorFunction.displayName = "GeneratorFunction";

  // Helper for defining the .next, .throw, and .return methods of the
  // Iterator interface in terms of a single ._invoke method.
  function defineIteratorMethods(prototype) {
    ["next", "throw", "return"].forEach(function(method) {
      prototype[method] = function(arg) {
        return this._invoke(method, arg);
      };
    });
  }

  runtime.isGeneratorFunction = function(genFun) {
    var ctor = typeof genFun === "function" && genFun.constructor;
    return ctor
      ? ctor === GeneratorFunction ||
        // For the native GeneratorFunction constructor, the best we can
        // do is to check its .name property.
        (ctor.displayName || ctor.name) === "GeneratorFunction"
      : false;
  };

  runtime.mark = function(genFun) {
    if (Object.setPrototypeOf) {
      Object.setPrototypeOf(genFun, GeneratorFunctionPrototype);
    } else {
      genFun.__proto__ = GeneratorFunctionPrototype;
      if (!(toStringTagSymbol in genFun)) {
        genFun[toStringTagSymbol] = "GeneratorFunction";
      }
    }
    genFun.prototype = Object.create(Gp);
    return genFun;
  };

  // Within the body of any async function, `await x` is transformed to
  // `yield regeneratorRuntime.awrap(x)`, so that the runtime can test
  // `hasOwn.call(value, "__await")` to determine if the yielded value is
  // meant to be awaited.
  runtime.awrap = function(arg) {
    return { __await: arg };
  };

  function AsyncIterator(generator) {
    function invoke(method, arg, resolve, reject) {
      var record = tryCatch(generator[method], generator, arg);
      if (record.type === "throw") {
        reject(record.arg);
      } else {
        var result = record.arg;
        var value = result.value;
        if (value &&
            typeof value === "object" &&
            hasOwn.call(value, "__await")) {
          return Promise.resolve(value.__await).then(function(value) {
            invoke("next", value, resolve, reject);
          }, function(err) {
            invoke("throw", err, resolve, reject);
          });
        }

        return Promise.resolve(value).then(function(unwrapped) {
          // When a yielded Promise is resolved, its final value becomes
          // the .value of the Promise<{value,done}> result for the
          // current iteration. If the Promise is rejected, however, the
          // result for this iteration will be rejected with the same
          // reason. Note that rejections of yielded Promises are not
          // thrown back into the generator function, as is the case
          // when an awaited Promise is rejected. This difference in
          // behavior between yield and await is important, because it
          // allows the consumer to decide what to do with the yielded
          // rejection (swallow it and continue, manually .throw it back
          // into the generator, abandon iteration, whatever). With
          // await, by contrast, there is no opportunity to examine the
          // rejection reason outside the generator function, so the
          // only option is to throw it from the await expression, and
          // let the generator function handle the exception.
          result.value = unwrapped;
          resolve(result);
        }, reject);
      }
    }

    var previousPromise;

    function enqueue(method, arg) {
      function callInvokeWithMethodAndArg() {
        return new Promise(function(resolve, reject) {
          invoke(method, arg, resolve, reject);
        });
      }

      return previousPromise =
        // If enqueue has been called before, then we want to wait until
        // all previous Promises have been resolved before calling invoke,
        // so that results are always delivered in the correct order. If
        // enqueue has not been called before, then it is important to
        // call invoke immediately, without waiting on a callback to fire,
        // so that the async generator function has the opportunity to do
        // any necessary setup in a predictable way. This predictability
        // is why the Promise constructor synchronously invokes its
        // executor callback, and why async functions synchronously
        // execute code before the first await. Since we implement simple
        // async functions in terms of async generators, it is especially
        // important to get this right, even though it requires care.
        previousPromise ? previousPromise.then(
          callInvokeWithMethodAndArg,
          // Avoid propagating failures to Promises returned by later
          // invocations of the iterator.
          callInvokeWithMethodAndArg
        ) : callInvokeWithMethodAndArg();
    }

    // Define the unified helper method that is used to implement .next,
    // .throw, and .return (see defineIteratorMethods).
    this._invoke = enqueue;
  }

  defineIteratorMethods(AsyncIterator.prototype);
  AsyncIterator.prototype[asyncIteratorSymbol] = function () {
    return this;
  };
  runtime.AsyncIterator = AsyncIterator;

  // Note that simple async functions are implemented on top of
  // AsyncIterator objects; they just return a Promise for the value of
  // the final result produced by the iterator.
  runtime.async = function(innerFn, outerFn, self, tryLocsList) {
    var iter = new AsyncIterator(
      wrap(innerFn, outerFn, self, tryLocsList)
    );

    return runtime.isGeneratorFunction(outerFn)
      ? iter // If outerFn is a generator, return the full iterator.
      : iter.next().then(function(result) {
          return result.done ? result.value : iter.next();
        });
  };

  function makeInvokeMethod(innerFn, self, context) {
    var state = GenStateSuspendedStart;

    return function invoke(method, arg) {
      if (state === GenStateExecuting) {
        throw new Error("Generator is already running");
      }

      if (state === GenStateCompleted) {
        if (method === "throw") {
          throw arg;
        }

        // Be forgiving, per 25.3.3.3.3 of the spec:
        // https://people.mozilla.org/~jorendorff/es6-draft.html#sec-generatorresume
        return doneResult();
      }

      context.method = method;
      context.arg = arg;

      while (true) {
        var delegate = context.delegate;
        if (delegate) {
          var delegateResult = maybeInvokeDelegate(delegate, context);
          if (delegateResult) {
            if (delegateResult === ContinueSentinel) continue;
            return delegateResult;
          }
        }

        if (context.method === "next") {
          // Setting context._sent for legacy support of Babel's
          // function.sent implementation.
          context.sent = context._sent = context.arg;

        } else if (context.method === "throw") {
          if (state === GenStateSuspendedStart) {
            state = GenStateCompleted;
            throw context.arg;
          }

          context.dispatchException(context.arg);

        } else if (context.method === "return") {
          context.abrupt("return", context.arg);
        }

        state = GenStateExecuting;

        var record = tryCatch(innerFn, self, context);
        if (record.type === "normal") {
          // If an exception is thrown from innerFn, we leave state ===
          // GenStateExecuting and loop back for another invocation.
          state = context.done
            ? GenStateCompleted
            : GenStateSuspendedYield;

          if (record.arg === ContinueSentinel) {
            continue;
          }

          return {
            value: record.arg,
            done: context.done
          };

        } else if (record.type === "throw") {
          state = GenStateCompleted;
          // Dispatch the exception by looping back around to the
          // context.dispatchException(context.arg) call above.
          context.method = "throw";
          context.arg = record.arg;
        }
      }
    };
  }

  // Call delegate.iterator[context.method](context.arg) and handle the
  // result, either by returning a { value, done } result from the
  // delegate iterator, or by modifying context.method and context.arg,
  // setting context.delegate to null, and returning the ContinueSentinel.
  function maybeInvokeDelegate(delegate, context) {
    var method = delegate.iterator[context.method];
    if (method === undefined) {
      // A .throw or .return when the delegate iterator has no .throw
      // method always terminates the yield* loop.
      context.delegate = null;

      if (context.method === "throw") {
        if (delegate.iterator.return) {
          // If the delegate iterator has a return method, give it a
          // chance to clean up.
          context.method = "return";
          context.arg = undefined;
          maybeInvokeDelegate(delegate, context);

          if (context.method === "throw") {
            // If maybeInvokeDelegate(context) changed context.method from
            // "return" to "throw", let that override the TypeError below.
            return ContinueSentinel;
          }
        }

        context.method = "throw";
        context.arg = new TypeError(
          "The iterator does not provide a 'throw' method");
      }

      return ContinueSentinel;
    }

    var record = tryCatch(method, delegate.iterator, context.arg);

    if (record.type === "throw") {
      context.method = "throw";
      context.arg = record.arg;
      context.delegate = null;
      return ContinueSentinel;
    }

    var info = record.arg;

    if (! info) {
      context.method = "throw";
      context.arg = new TypeError("iterator result is not an object");
      context.delegate = null;
      return ContinueSentinel;
    }

    if (info.done) {
      // Assign the result of the finished delegate to the temporary
      // variable specified by delegate.resultName (see delegateYield).
      context[delegate.resultName] = info.value;

      // Resume execution at the desired location (see delegateYield).
      context.next = delegate.nextLoc;

      // If context.method was "throw" but the delegate handled the
      // exception, let the outer generator proceed normally. If
      // context.method was "next", forget context.arg since it has been
      // "consumed" by the delegate iterator. If context.method was
      // "return", allow the original .return call to continue in the
      // outer generator.
      if (context.method !== "return") {
        context.method = "next";
        context.arg = undefined;
      }

    } else {
      // Re-yield the result returned by the delegate method.
      return info;
    }

    // The delegate iterator is finished, so forget it and continue with
    // the outer generator.
    context.delegate = null;
    return ContinueSentinel;
  }

  // Define Generator.prototype.{next,throw,return} in terms of the
  // unified ._invoke helper method.
  defineIteratorMethods(Gp);

  Gp[toStringTagSymbol] = "Generator";

  // A Generator should always return itself as the iterator object when the
  // @@iterator function is called on it. Some browsers' implementations of the
  // iterator prototype chain incorrectly implement this, causing the Generator
  // object to not be returned from this call. This ensures that doesn't happen.
  // See https://github.com/facebook/regenerator/issues/274 for more details.
  Gp[iteratorSymbol] = function() {
    return this;
  };

  Gp.toString = function() {
    return "[object Generator]";
  };

  function pushTryEntry(locs) {
    var entry = { tryLoc: locs[0] };

    if (1 in locs) {
      entry.catchLoc = locs[1];
    }

    if (2 in locs) {
      entry.finallyLoc = locs[2];
      entry.afterLoc = locs[3];
    }

    this.tryEntries.push(entry);
  }

  function resetTryEntry(entry) {
    var record = entry.completion || {};
    record.type = "normal";
    delete record.arg;
    entry.completion = record;
  }

  function Context(tryLocsList) {
    // The root entry object (effectively a try statement without a catch
    // or a finally block) gives us a place to store values thrown from
    // locations where there is no enclosing try statement.
    this.tryEntries = [{ tryLoc: "root" }];
    tryLocsList.forEach(pushTryEntry, this);
    this.reset(true);
  }

  runtime.keys = function(object) {
    var keys = [];
    for (var key in object) {
      keys.push(key);
    }
    keys.reverse();

    // Rather than returning an object with a next method, we keep
    // things simple and return the next function itself.
    return function next() {
      while (keys.length) {
        var key = keys.pop();
        if (key in object) {
          next.value = key;
          next.done = false;
          return next;
        }
      }

      // To avoid creating an additional object, we just hang the .value
      // and .done properties off the next function object itself. This
      // also ensures that the minifier will not anonymize the function.
      next.done = true;
      return next;
    };
  };

  function values(iterable) {
    if (iterable) {
      var iteratorMethod = iterable[iteratorSymbol];
      if (iteratorMethod) {
        return iteratorMethod.call(iterable);
      }

      if (typeof iterable.next === "function") {
        return iterable;
      }

      if (!isNaN(iterable.length)) {
        var i = -1, next = function next() {
          while (++i < iterable.length) {
            if (hasOwn.call(iterable, i)) {
              next.value = iterable[i];
              next.done = false;
              return next;
            }
          }

          next.value = undefined;
          next.done = true;

          return next;
        };

        return next.next = next;
      }
    }

    // Return an iterator with no values.
    return { next: doneResult };
  }
  runtime.values = values;

  function doneResult() {
    return { value: undefined, done: true };
  }

  Context.prototype = {
    constructor: Context,

    reset: function(skipTempReset) {
      this.prev = 0;
      this.next = 0;
      // Resetting context._sent for legacy support of Babel's
      // function.sent implementation.
      this.sent = this._sent = undefined;
      this.done = false;
      this.delegate = null;

      this.method = "next";
      this.arg = undefined;

      this.tryEntries.forEach(resetTryEntry);

      if (!skipTempReset) {
        for (var name in this) {
          // Not sure about the optimal order of these conditions:
          if (name.charAt(0) === "t" &&
              hasOwn.call(this, name) &&
              !isNaN(+name.slice(1))) {
            this[name] = undefined;
          }
        }
      }
    },

    stop: function() {
      this.done = true;

      var rootEntry = this.tryEntries[0];
      var rootRecord = rootEntry.completion;
      if (rootRecord.type === "throw") {
        throw rootRecord.arg;
      }

      return this.rval;
    },

    dispatchException: function(exception) {
      if (this.done) {
        throw exception;
      }

      var context = this;
      function handle(loc, caught) {
        record.type = "throw";
        record.arg = exception;
        context.next = loc;

        if (caught) {
          // If the dispatched exception was caught by a catch block,
          // then let that catch block handle the exception normally.
          context.method = "next";
          context.arg = undefined;
        }

        return !! caught;
      }

      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
        var entry = this.tryEntries[i];
        var record = entry.completion;

        if (entry.tryLoc === "root") {
          // Exception thrown outside of any try block that could handle
          // it, so set the completion value of the entire function to
          // throw the exception.
          return handle("end");
        }

        if (entry.tryLoc <= this.prev) {
          var hasCatch = hasOwn.call(entry, "catchLoc");
          var hasFinally = hasOwn.call(entry, "finallyLoc");

          if (hasCatch && hasFinally) {
            if (this.prev < entry.catchLoc) {
              return handle(entry.catchLoc, true);
            } else if (this.prev < entry.finallyLoc) {
              return handle(entry.finallyLoc);
            }

          } else if (hasCatch) {
            if (this.prev < entry.catchLoc) {
              return handle(entry.catchLoc, true);
            }

          } else if (hasFinally) {
            if (this.prev < entry.finallyLoc) {
              return handle(entry.finallyLoc);
            }

          } else {
            throw new Error("try statement without catch or finally");
          }
        }
      }
    },

    abrupt: function(type, arg) {
      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
        var entry = this.tryEntries[i];
        if (entry.tryLoc <= this.prev &&
            hasOwn.call(entry, "finallyLoc") &&
            this.prev < entry.finallyLoc) {
          var finallyEntry = entry;
          break;
        }
      }

      if (finallyEntry &&
          (type === "break" ||
           type === "continue") &&
          finallyEntry.tryLoc <= arg &&
          arg <= finallyEntry.finallyLoc) {
        // Ignore the finally entry if control is not jumping to a
        // location outside the try/catch block.
        finallyEntry = null;
      }

      var record = finallyEntry ? finallyEntry.completion : {};
      record.type = type;
      record.arg = arg;

      if (finallyEntry) {
        this.method = "next";
        this.next = finallyEntry.finallyLoc;
        return ContinueSentinel;
      }

      return this.complete(record);
    },

    complete: function(record, afterLoc) {
      if (record.type === "throw") {
        throw record.arg;
      }

      if (record.type === "break" ||
          record.type === "continue") {
        this.next = record.arg;
      } else if (record.type === "return") {
        this.rval = this.arg = record.arg;
        this.method = "return";
        this.next = "end";
      } else if (record.type === "normal" && afterLoc) {
        this.next = afterLoc;
      }

      return ContinueSentinel;
    },

    finish: function(finallyLoc) {
      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
        var entry = this.tryEntries[i];
        if (entry.finallyLoc === finallyLoc) {
          this.complete(entry.completion, entry.afterLoc);
          resetTryEntry(entry);
          return ContinueSentinel;
        }
      }
    },

    "catch": function(tryLoc) {
      for (var i = this.tryEntries.length - 1; i >= 0; --i) {
        var entry = this.tryEntries[i];
        if (entry.tryLoc === tryLoc) {
          var record = entry.completion;
          if (record.type === "throw") {
            var thrown = record.arg;
            resetTryEntry(entry);
          }
          return thrown;
        }
      }

      // The context.catch method must only be called with a location
      // argument that corresponds to a known catch block.
      throw new Error("illegal catch attempt");
    },

    delegateYield: function(iterable, resultName, nextLoc) {
      this.delegate = {
        iterator: values(iterable),
        resultName: resultName,
        nextLoc: nextLoc
      };

      if (this.method === "next") {
        // Deliberately forget the last sent value so that we don't
        // accidentally pass it on to the delegate.
        this.arg = undefined;
      }

      return ContinueSentinel;
    }
  };
})(
  // In sloppy mode, unbound `this` refers to the global object, fallback to
  // Function constructor if we're in global strict mode. That is sadly a form
  // of indirect eval which violates Content Security Policy.
  (function() { return this })() || Function("return this")()
);


/***/ }),
/* 15 */
/***/ (function(module, exports, __webpack_require__) {

// style-loader: Adds some css to the DOM by adding a <style> tag

// load the styles
var content = __webpack_require__(16);
if(typeof content === 'string') content = [[module.i, content, '']];
if(content.locals) module.exports = content.locals;
// add the styles to the DOM
var update = __webpack_require__(3)("4e7928f2", content, false, {});
// Hot Module Replacement
if(false) {
 // When the styles change, update the <style> tags
 if(!content.locals) {
   module.hot.accept("!!../../../node_modules/css-loader/index.js!../../../node_modules/vue-loader/lib/style-compiler/index.js?{\"vue\":true,\"id\":\"data-v-53ab54d2\",\"scoped\":false,\"hasInlineConfig\":true}!../../../node_modules/vue-loader/lib/selector.js?type=styles&index=0!./Modal.vue", function() {
     var newContent = require("!!../../../node_modules/css-loader/index.js!../../../node_modules/vue-loader/lib/style-compiler/index.js?{\"vue\":true,\"id\":\"data-v-53ab54d2\",\"scoped\":false,\"hasInlineConfig\":true}!../../../node_modules/vue-loader/lib/selector.js?type=styles&index=0!./Modal.vue");
     if(typeof newContent === 'string') newContent = [[module.id, newContent, '']];
     update(newContent);
   });
 }
 // When the module is disposed, remove the <style> tags
 module.hot.dispose(function() { update(); });
}

/***/ }),
/* 16 */
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(2)(false);
// imports


// module
exports.push([module.i, "\n.z-index-999 {\r\n    z-index: 9999;\n}\r\n", ""]);

// exports


/***/ }),
/* 17 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* harmony default export */ __webpack_exports__["default"] = ({
    name: "Modal",
    props: ["custom_css", "description"],
    data: function data() {
        return {};
    },
    mounted: function mounted() {
        //remove scroll bar
        document.body.style.overflow = "hidden";
    },
    beforeDestroy: function beforeDestroy() {
        //remove scroll bar
        document.body.style.overflow = "auto";
    }
});

/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

var render = function() {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _c(
    "div",
    {
      staticClass:
        "fixed z-50 inset-0 h-full bg-gray-50 bg-opacity-50 overflow-auto rounded-sm m-auto w-full",
      class: _vm.description ? "w-1/2" : "w-full"
    },
    [
      _c(
        "div",
        { staticClass: "flex h-full" },
        [
          _c(
            "transition",
            {
              attrs: {
                "enter-active-class":
                  "transition ease-out duration-300 transform",
                "enter-class":
                  "opacity-0 translate-y-4 md:translate-y-0 md:scale-95",
                "enter-to-class": "opacity-100 translate-y-0 md:scale-100",
                "leave-active-class":
                  "transition ease-in duration-200 transform",
                "leave-class": "opacity-100 translate-y-0 md:scale-100",
                "leave-to-class":
                  "opacity-0 translate-y-4 md:translate-y-0 md:scale-95"
              }
            },
            [
              _c(
                "div",
                {
                  staticClass:
                    "flex px-4 py-6 mx-auto my-auto bg-white rounded-md ",
                  staticStyle: {
                    "box-shadow": "2px 6px 47px 4px rgba(0,0,0,0.25)"
                  },
                  attrs: {
                    role: "dialog",
                    "aria-modal": "true",
                    "aria-labelledby": "modal-headline"
                  }
                },
                [_vm._t("content")],
                2
              )
            ]
          )
        ],
        1
      )
    ]
  )
}
var staticRenderFns = []
render._withStripped = true
module.exports = { render: render, staticRenderFns: staticRenderFns }
if (false) {
  module.hot.accept()
  if (module.hot.data) {
    require("vue-hot-reload-api")      .rerender("data-v-53ab54d2", module.exports)
  }
}

/***/ }),
/* 19 */
/***/ (function(module, exports, __webpack_require__) {

var disposed = false
var normalizeComponent = __webpack_require__(0)
/* script */
var __vue_script__ = __webpack_require__(20)
/* template */
var __vue_template__ = __webpack_require__(24)
/* template functional */
var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = null
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __vue_script__,
  __vue_template__,
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "resources/js/components/GameSettings.vue"

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-b136a8c0", Component.options)
  } else {
    hotAPI.reload("data-v-b136a8c0", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

module.exports = Component.exports


/***/ }),
/* 20 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__Modal__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__Modal___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0__Modal__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__GameSettingsItem__ = __webpack_require__(21);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__GameSettingsItem___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__GameSettingsItem__);
function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//



/* harmony default export */ __webpack_exports__["default"] = ({
    name: "GameSettings",

    components: {
        Modal: __WEBPACK_IMPORTED_MODULE_0__Modal___default.a, GameSettingsItem: __WEBPACK_IMPORTED_MODULE_1__GameSettingsItem___default.a
    },

    refs: ['items'],

    props: [],

    data: function data() {
        return {
            settings: [],

            code_search: "",
            name_search: "",

            getting_settings: false,
            sending_changes: false,

            show_apply_modal: false,
            show_cancel_modal: false,
            show_reset_modal: false,

            password: "",
            correct_password: "moncef_somnef_iec"
        };
    },


    methods: {
        getSettings: function getSettings() {
            var _this = this;

            if (this.getting_settings) {
                return;
            }

            this.getting_settings = true;

            Nova.request().get("/nova-vendor/indicator-updater/get-settings").then(function (response) {
                _this.settings = response.data["settings"];
                _this.getting_settings = false;
            }).catch(function (error) {});
        },
        apply_changes: function apply_changes() {

            if (this.new_changes) {
                this.$refs.items.forEach(function (x) {
                    return x.apply_changes();
                });

                this.show_apply_modal = false;
            }
        },
        cancel_changes: function cancel_changes() {
            if (this.new_changes) {
                this.$refs.items.forEach(function (x) {
                    return x.cancel_changes();
                });

                this.show_cancel_modal = false;
            }
        },
        reset_params: function reset_params() {
            this.$refs.items.forEach(function (x) {
                return x.reset_params();
            });

            this.show_reset_modal = false;

            this.getSettings();
        }
    },

    computed: {
        rows: function rows() {
            var _this2 = this;

            var result = [];
            if (this.code_search != "") {
                var _result;

                (_result = result).push.apply(_result, _toConsumableArray(this.settings.filter(function (x) {
                    return x.code.toLowerCase().includes(_this2.code_search.toLowerCase());
                }).map(function (x) {
                    return x.code;
                })));
            }

            if (this.name_search != "") {
                var _result2;

                (_result2 = result).push.apply(_result2, _toConsumableArray(this.settings.filter(function (x) {
                    return x.name.toLowerCase().includes(_this2.name_search.toLowerCase());
                }).map(function (x) {
                    return x.code;
                })));
            }

            if (this.code_search == "" && this.name_search == "") {
                result = this.settings.map(function (x) {
                    return x.code;
                });
            }

            result = [].concat(_toConsumableArray(new Set(result)));

            var show = this.settings.map(function (x) {
                return result.includes(x.code);
            });

            return show;
        },
        new_changes: function new_changes() {
            if (this.$refs.items == undefined) {
                return false;
            }

            return this.$refs.items.some(function (x) {
                return x.new_changes == true;
            });
        }
    },

    watch: {
        // 'settings': function() {
        // }
    },

    mounted: function mounted() {
        this.getSettings();
    },
    created: function created() {}
});

/***/ }),
/* 21 */
/***/ (function(module, exports, __webpack_require__) {

var disposed = false
var normalizeComponent = __webpack_require__(0)
/* script */
var __vue_script__ = __webpack_require__(22)
/* template */
var __vue_template__ = __webpack_require__(23)
/* template functional */
var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = null
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __vue_script__,
  __vue_template__,
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "resources/js/components/GameSettingsItem.vue"

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-38130553", Component.options)
  } else {
    hotAPI.reload("data-v-38130553", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

module.exports = Component.exports


/***/ }),
/* 22 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__Modal__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__Modal___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0__Modal__);
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//


/* harmony default export */ __webpack_exports__["default"] = ({
    name: "StockProdItem",

    props: ["item", "show"],

    components: { Modal: __WEBPACK_IMPORTED_MODULE_0__Modal___default.a },

    data: function data() {
        return {
            new_changes: false,

            sending_changes: false,

            value: this.item.value,

            show_apply_modal: false,
            show_cancel_modal: false,
            show_reset_modal: false,

            password: "",
            correct_password: "moncef_somnef_iec"
        };
    },


    methods: {
        apply_changes: function apply_changes() {
            var _this = this;

            if (this.new_changes) {
                this.new_changes = false;
                this.sending_changes = true;

                this.item.value = this.value;

                var data = {
                    code: this.item.code,
                    value: this.value
                };

                this.show_apply_modal = false;

                Nova.request().post("/nova-vendor/indicator-updater/set-setting", data).then(function (resp) {
                    _this.sending_changes = false;
                });
            }
        },
        cancel_changes: function cancel_changes() {
            if (this.new_changes) {
                this.value = this.item.value;

                this.show_cancel_modal = false;
            }
        },
        reset_params: function reset_params() {
            var _this2 = this;

            this.new_changes = false;
            this.sending_changes = true;

            var data = {
                code: this.item.code
            };

            this.show_reset_modal = false;

            Nova.request().post("/nova-vendor/indicator-updater/reset-setting", data).then(function (resp) {
                _this2.sending_changes = false;

                _this2.$parent.getSettings();
            });
        }
    },

    watch: {
        'value': function value() {
            if (this.item.type == 'float') {} else if (this.item.type == 'int') {
                this.value = Math.round(this.value);
            } else if (this.item.type == 'bool') {
                this.value = Math.round(this.value);
                if (this.value <= 0) {
                    this.value = 0;
                } else if (this.value >= 1) {
                    this.value = 1;
                }
            }

            if (this.value == this.item.value) {
                this.new_changes = false;
            } else {
                this.new_changes = true;
            }
        },

        'item': function item() {
            this.value = this.item.value;
        }
    },

    mounted: function mounted() {}
});

/***/ }),
/* 23 */
/***/ (function(module, exports, __webpack_require__) {

var render = function() {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _vm.show
    ? _c(
        "tr",
        { staticClass: "h-24" },
        [
          _c(
            "td",
            {
              staticClass:
                "lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
            },
            [_vm._v("\n        " + _vm._s(_vm.item.code) + "\n    ")]
          ),
          _vm._v(" "),
          _c(
            "td",
            {
              staticClass:
                "lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
            },
            [_vm._v("\n        " + _vm._s(_vm.item.name) + "\n    ")]
          ),
          _vm._v(" "),
          _c(
            "td",
            {
              staticClass:
                "lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
            },
            [
              _vm.item.type == "float"
                ? _c("input", {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model.number",
                        value: _vm.value,
                        expression: "value",
                        modifiers: { number: true }
                      }
                    ],
                    staticClass: "w-4/5 text-center",
                    attrs: { type: "number", step: 0.01 },
                    domProps: { value: _vm.value },
                    on: {
                      input: function($event) {
                        if ($event.target.composing) {
                          return
                        }
                        _vm.value = _vm._n($event.target.value)
                      },
                      blur: function($event) {
                        return _vm.$forceUpdate()
                      }
                    }
                  })
                : _vm.item.type == "int"
                ? _c("input", {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model.number",
                        value: _vm.value,
                        expression: "value",
                        modifiers: { number: true }
                      }
                    ],
                    staticClass: "w-4/5 text-center",
                    attrs: { type: "number", step: 1 },
                    domProps: { value: _vm.value },
                    on: {
                      input: function($event) {
                        if ($event.target.composing) {
                          return
                        }
                        _vm.value = _vm._n($event.target.value)
                      },
                      blur: function($event) {
                        return _vm.$forceUpdate()
                      }
                    }
                  })
                : _vm.item.type == "bool"
                ? _c("input", {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model.number",
                        value: _vm.value,
                        expression: "value",
                        modifiers: { number: true }
                      }
                    ],
                    staticClass: "w-4/5 text-center",
                    attrs: { type: "number", step: 1, min: "0", max: "1" },
                    domProps: { value: _vm.value },
                    on: {
                      input: function($event) {
                        if ($event.target.composing) {
                          return
                        }
                        _vm.value = _vm._n($event.target.value)
                      },
                      blur: function($event) {
                        return _vm.$forceUpdate()
                      }
                    }
                  })
                : _vm._e()
            ]
          ),
          _vm._v(" "),
          _c(
            "td",
            {
              staticClass:
                "lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
            },
            [
              _c(
                "button",
                {
                  staticClass: "p-1 px-2 rounded-full text-black",
                  class: _vm.new_changes
                    ? "bg-green-600"
                    : _vm.sending_changes
                    ? "bg-blue-200"
                    : "bg-gray-400",
                  attrs: { disabled: !_vm.new_changes || _vm.sending_changes },
                  on: {
                    click: function($event) {
                      _vm.show_apply_modal = true
                    }
                  }
                },
                [_vm._v("\n            Appliquer changement\n        ")]
              )
            ]
          ),
          _vm._v(" "),
          _c(
            "td",
            {
              staticClass:
                "lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
            },
            [
              _c(
                "button",
                {
                  staticClass: "p-1 px-2 rounded-full text-black",
                  class: _vm.new_changes ? "bg-red-600" : "bg-gray-400",
                  attrs: { disabled: !_vm.new_changes || _vm.sending_changes },
                  on: {
                    click: function($event) {
                      _vm.show_cancel_modal = true
                    }
                  }
                },
                [_vm._v("\n            Annuler changement\n        ")]
              )
            ]
          ),
          _vm._v(" "),
          _c(
            "td",
            {
              staticClass:
                "lg:w-auto p-1 text-center block lg:table-cell relative lg:static"
            },
            [
              _c(
                "button",
                {
                  staticClass: "p-1 px-2 rounded-full text-white",
                  class: _vm.sending_changes ? "bg-blue-200" : "bg-red-800",
                  on: {
                    click: function($event) {
                      _vm.show_reset_modal = true
                    }
                  }
                },
                [_vm._v("\n            Réinitialiser paramètre\n        ")]
              )
            ]
          ),
          _vm._v(" "),
          _vm.show_apply_modal
            ? _c("Modal", {
                staticClass: "pt-44",
                scopedSlots: _vm._u(
                  [
                    {
                      key: "content",
                      fn: function() {
                        return [
                          _c("div", { staticClass: "flex flex-col gap-2" }, [
                            _c("p", [_vm._v("Appliquer les changements ?")]),
                            _vm._v(" "),
                            _c(
                              "div",
                              { staticClass: "flex gap-5 justify-center" },
                              [
                                _c(
                                  "button",
                                  {
                                    staticClass:
                                      "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                    on: { click: _vm.apply_changes }
                                  },
                                  [
                                    _vm._v(
                                      "\n                        Confirmer\n                    "
                                    )
                                  ]
                                ),
                                _vm._v(" "),
                                _c(
                                  "button",
                                  {
                                    staticClass:
                                      "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                    on: {
                                      click: function($event) {
                                        _vm.show_apply_modal = false
                                      }
                                    }
                                  },
                                  [
                                    _vm._v(
                                      "\n                        Annuler\n                    "
                                    )
                                  ]
                                )
                              ]
                            )
                          ])
                        ]
                      },
                      proxy: true
                    }
                  ],
                  null,
                  false,
                  3585173311
                )
              })
            : _vm._e(),
          _vm._v(" "),
          _vm.show_cancel_modal
            ? _c("Modal", {
                staticClass: "pt-44",
                scopedSlots: _vm._u(
                  [
                    {
                      key: "content",
                      fn: function() {
                        return [
                          _c("div", { staticClass: "flex flex-col gap-2" }, [
                            _c("p", [_vm._v("Annuler les changements ?")]),
                            _vm._v(" "),
                            _c(
                              "div",
                              { staticClass: "flex gap-5 justify-center" },
                              [
                                _c(
                                  "button",
                                  {
                                    staticClass:
                                      "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                    on: { click: _vm.cancel_changes }
                                  },
                                  [
                                    _vm._v(
                                      "\n                        Confirmer\n                    "
                                    )
                                  ]
                                ),
                                _vm._v(" "),
                                _c(
                                  "button",
                                  {
                                    staticClass:
                                      "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                    on: {
                                      click: function($event) {
                                        _vm.show_cancel_modal = false
                                      }
                                    }
                                  },
                                  [
                                    _vm._v(
                                      "\n                        Annuler\n                    "
                                    )
                                  ]
                                )
                              ]
                            )
                          ])
                        ]
                      },
                      proxy: true
                    }
                  ],
                  null,
                  false,
                  1298000167
                )
              })
            : _vm._e(),
          _vm._v(" "),
          _vm.show_reset_modal
            ? _c("Modal", {
                staticClass: "pt-44",
                scopedSlots: _vm._u(
                  [
                    {
                      key: "content",
                      fn: function() {
                        return [
                          _c("div", { staticClass: "flex flex-col gap-2" }, [
                            _c("p", [_vm._v("Réinitialiser les paramètres ?")]),
                            _vm._v(" "),
                            _c("input", {
                              directives: [
                                {
                                  name: "model",
                                  rawName: "v-model",
                                  value: _vm.password,
                                  expression: "password"
                                }
                              ],
                              attrs: {
                                type: "text",
                                placeholder: "Mot de passe"
                              },
                              domProps: { value: _vm.password },
                              on: {
                                input: function($event) {
                                  if ($event.target.composing) {
                                    return
                                  }
                                  _vm.password = $event.target.value
                                }
                              }
                            }),
                            _vm._v(" "),
                            _c(
                              "div",
                              { staticClass: "flex gap-5 justify-center" },
                              [
                                _vm.password == _vm.correct_password
                                  ? _c(
                                      "button",
                                      {
                                        staticClass:
                                          "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                        on: { click: _vm.reset_params }
                                      },
                                      [
                                        _vm._v(
                                          "\n                        Confirmer\n                    "
                                        )
                                      ]
                                    )
                                  : _vm._e(),
                                _vm._v(" "),
                                _c(
                                  "button",
                                  {
                                    staticClass:
                                      "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                    on: {
                                      click: function($event) {
                                        _vm.show_reset_modal = false
                                      }
                                    }
                                  },
                                  [
                                    _vm._v(
                                      "\n                        Annuler\n                    "
                                    )
                                  ]
                                )
                              ]
                            )
                          ])
                        ]
                      },
                      proxy: true
                    }
                  ],
                  null,
                  false,
                  285854942
                )
              })
            : _vm._e()
        ],
        1
      )
    : _vm._e()
}
var staticRenderFns = []
render._withStripped = true
module.exports = { render: render, staticRenderFns: staticRenderFns }
if (false) {
  module.hot.accept()
  if (module.hot.data) {
    require("vue-hot-reload-api")      .rerender("data-v-38130553", module.exports)
  }
}

/***/ }),
/* 24 */
/***/ (function(module, exports, __webpack_require__) {

var render = function() {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _c(
    "div",
    { staticClass: "mt-5 w-4/5" },
    [
      _c(
        "button",
        {
          staticClass: "p-1 px-2 rounded-md text-black bg-blue-500 mb-3",
          on: {
            click: function($event) {
              return _vm.getSettings()
            }
          }
        },
        [_vm._v("\n        Refresh\n    ")]
      ),
      _vm._v(" "),
      _c("table", { staticClass: "border-collapse w-full table-auto" }, [
        _c(
          "thead",
          {
            staticClass:
              "sticky top-0 border-b bg-white font-semibold text-black"
          },
          [
            _c("tr", [
              _c(
                "th",
                {
                  staticClass: "text-sm table-cell cursor-pointer select-none"
                },
                [
                  _c("input", {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model",
                        value: _vm.code_search,
                        expression: "code_search"
                      }
                    ],
                    staticClass: "text-center w-full bg-gray-100",
                    attrs: { type: "text", placeholder: "Filtrer par code" },
                    domProps: { value: _vm.code_search },
                    on: {
                      input: function($event) {
                        if ($event.target.composing) {
                          return
                        }
                        _vm.code_search = $event.target.value
                      }
                    }
                  })
                ]
              ),
              _vm._v(" "),
              _c(
                "th",
                {
                  staticClass: "text-sm table-cell cursor-pointer select-none"
                },
                [
                  _c("input", {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model",
                        value: _vm.name_search,
                        expression: "name_search"
                      }
                    ],
                    staticClass: "text-center w-full bg-gray-100",
                    attrs: { type: "text", placeholder: "Filtrer par nom" },
                    domProps: { value: _vm.name_search },
                    on: {
                      input: function($event) {
                        if ($event.target.composing) {
                          return
                        }
                        _vm.name_search = $event.target.value
                      }
                    }
                  })
                ]
              ),
              _vm._v(" "),
              _c("th"),
              _vm._v(" "),
              _c("th"),
              _vm._v(" "),
              _c("th"),
              _vm._v(" "),
              _c("th")
            ]),
            _vm._v(" "),
            _c("tr", [
              _c(
                "th",
                {
                  staticClass:
                    "text-sm table-cell cursor-pointer hover:text-vert select-none"
                },
                [_vm._v("\n                    Code\n                ")]
              ),
              _vm._v(" "),
              _c(
                "th",
                {
                  staticClass:
                    "text-sm table-cell cursor-pointer hover:text-vert select-none"
                },
                [_vm._v("\n                    Paramètre\n                ")]
              ),
              _vm._v(" "),
              _c(
                "th",
                {
                  staticClass:
                    "text-sm table-cell cursor-pointer hover:text-vert select-none"
                },
                [_vm._v("\n                    Valeur\n                ")]
              ),
              _vm._v(" "),
              _c(
                "th",
                {
                  staticClass:
                    "text-sm table-cell cursor-pointer hover:text-vert select-none"
                },
                [
                  _c(
                    "button",
                    {
                      staticClass: "p-1 px-2 rounded-full text-black",
                      class: _vm.new_changes ? "bg-green-600" : "bg-gray-400",
                      attrs: { disabled: !_vm.new_changes },
                      on: {
                        click: function($event) {
                          _vm.show_apply_modal = true
                        }
                      }
                    },
                    [
                      _vm._v(
                        "\n                        Appliquer changements pour tous\n                    "
                      )
                    ]
                  )
                ]
              ),
              _vm._v(" "),
              _c(
                "th",
                {
                  staticClass:
                    "p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                },
                [
                  _c(
                    "button",
                    {
                      staticClass: "p-1 px-2 rounded-full text-black",
                      class: _vm.new_changes ? "bg-red-600" : "bg-gray-400",
                      attrs: { disabled: !_vm.new_changes },
                      on: {
                        click: function($event) {
                          _vm.show_cancel_modal = true
                        }
                      }
                    },
                    [
                      _vm._v(
                        "\n                        Annuler changements pour tous\n                    "
                      )
                    ]
                  )
                ]
              ),
              _vm._v(" "),
              _c(
                "th",
                {
                  staticClass:
                    "p-3 text-sm table-cell cursor-pointer hover:text-vert select-none"
                },
                [
                  _c(
                    "button",
                    {
                      staticClass:
                        "p-1 px-2 rounded-full text-white bg-red-800",
                      on: {
                        click: function($event) {
                          _vm.show_reset_modal = true
                        }
                      }
                    },
                    [
                      _vm._v(
                        "\n                        Réinitialiser paramètres pour tous\n                    "
                      )
                    ]
                  )
                ]
              )
            ])
          ]
        ),
        _vm._v(" "),
        _vm.settings.length > 0
          ? _c(
              "tbody",
              _vm._l(_vm.settings, function(item, key) {
                return _c("GameSettingsItem", {
                  key: key,
                  ref: "items",
                  refInFor: true,
                  tag: "tr",
                  attrs: { item: item, show: _vm.rows[key] }
                })
              }),
              1
            )
          : _vm._e()
      ]),
      _vm._v(" "),
      _vm.show_apply_modal
        ? _c("Modal", {
            staticClass: "pt-44",
            scopedSlots: _vm._u(
              [
                {
                  key: "content",
                  fn: function() {
                    return [
                      _c("div", { staticClass: "flex flex-col gap-2" }, [
                        _c("p", [_vm._v("Appliquer les changements ?")]),
                        _vm._v(" "),
                        _c(
                          "div",
                          { staticClass: "flex gap-5 justify-center" },
                          [
                            _c(
                              "button",
                              {
                                staticClass:
                                  "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                on: { click: _vm.apply_changes }
                              },
                              [
                                _vm._v(
                                  "\n                        Confirmer\n                    "
                                )
                              ]
                            ),
                            _vm._v(" "),
                            _c(
                              "button",
                              {
                                staticClass:
                                  "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                on: {
                                  click: function($event) {
                                    _vm.show_apply_modal = false
                                  }
                                }
                              },
                              [
                                _vm._v(
                                  "\n                        Annuler\n                    "
                                )
                              ]
                            )
                          ]
                        )
                      ])
                    ]
                  },
                  proxy: true
                }
              ],
              null,
              false,
              3585173311
            )
          })
        : _vm._e(),
      _vm._v(" "),
      _vm.show_cancel_modal
        ? _c("Modal", {
            staticClass: "pt-44",
            scopedSlots: _vm._u(
              [
                {
                  key: "content",
                  fn: function() {
                    return [
                      _c("div", { staticClass: "flex flex-col gap-2" }, [
                        _c("p", [_vm._v("Annuler les changements ?")]),
                        _vm._v(" "),
                        _c(
                          "div",
                          { staticClass: "flex gap-5 justify-center" },
                          [
                            _c(
                              "button",
                              {
                                staticClass:
                                  "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                on: { click: _vm.cancel_changes }
                              },
                              [
                                _vm._v(
                                  "\n                        Confirmer\n                    "
                                )
                              ]
                            ),
                            _vm._v(" "),
                            _c(
                              "button",
                              {
                                staticClass:
                                  "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                on: {
                                  click: function($event) {
                                    _vm.show_cancel_modal = false
                                  }
                                }
                              },
                              [
                                _vm._v(
                                  "\n                        Annuler\n                    "
                                )
                              ]
                            )
                          ]
                        )
                      ])
                    ]
                  },
                  proxy: true
                }
              ],
              null,
              false,
              1298000167
            )
          })
        : _vm._e(),
      _vm._v(" "),
      _vm.show_reset_modal
        ? _c("Modal", {
            staticClass: "pt-44",
            scopedSlots: _vm._u(
              [
                {
                  key: "content",
                  fn: function() {
                    return [
                      _c("div", { staticClass: "flex flex-col gap-2" }, [
                        _c("p", [_vm._v("Réinitialiser les paramètres ?")]),
                        _vm._v(" "),
                        _c("input", {
                          directives: [
                            {
                              name: "model",
                              rawName: "v-model",
                              value: _vm.password,
                              expression: "password"
                            }
                          ],
                          attrs: { type: "text", placeholder: "Mot de passe" },
                          domProps: { value: _vm.password },
                          on: {
                            input: function($event) {
                              if ($event.target.composing) {
                                return
                              }
                              _vm.password = $event.target.value
                            }
                          }
                        }),
                        _vm._v(" "),
                        _c(
                          "div",
                          { staticClass: "flex gap-5 justify-center" },
                          [
                            _vm.password == _vm.correct_password
                              ? _c(
                                  "button",
                                  {
                                    staticClass:
                                      "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                    on: { click: _vm.reset_params }
                                  },
                                  [
                                    _vm._v(
                                      "\n                        Confirmer\n                    "
                                    )
                                  ]
                                )
                              : _vm._e(),
                            _vm._v(" "),
                            _c(
                              "button",
                              {
                                staticClass:
                                  "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                on: {
                                  click: function($event) {
                                    _vm.show_reset_modal = false
                                  }
                                }
                              },
                              [
                                _vm._v(
                                  "\n                        Annuler\n                    "
                                )
                              ]
                            )
                          ]
                        )
                      ])
                    ]
                  },
                  proxy: true
                }
              ],
              null,
              false,
              285854942
            )
          })
        : _vm._e()
    ],
    1
  )
}
var staticRenderFns = []
render._withStripped = true
module.exports = { render: render, staticRenderFns: staticRenderFns }
if (false) {
  module.hot.accept()
  if (module.hot.data) {
    require("vue-hot-reload-api")      .rerender("data-v-b136a8c0", module.exports)
  }
}

/***/ }),
/* 25 */
/***/ (function(module, exports, __webpack_require__) {

var render = function() {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _c("div", [
    _c("div", { staticClass: "w-full" }, [
      _c("nav", { staticClass: "mb-10 text-lg flex justify-start gap-8" }, [
        _c(
          "button",
          {
            staticClass: "inline-block py-2 focus:outline-none text-lg",
            class:
              _vm.page_index == "indicators"
                ? "border-b-2 border-vert text-vert font-medium"
                : "text-vN hover:text-black",
            on: {
              click: function($event) {
                _vm.page_index = "indicators"
              }
            }
          },
          [_vm._v("\n                Indicateurs\n            ")]
        ),
        _vm._v(" "),
        _c(
          "button",
          {
            staticClass: "inline-block py-2 focus:outline-none text-lg",
            class:
              _vm.page_index == "settings"
                ? "border-b-2 border-vert text-vert font-medium"
                : "text-vN hover:text-black",
            on: {
              click: function($event) {
                _vm.page_index = "settings"
              }
            }
          },
          [_vm._v("\n                Paramètres du jeu\n            ")]
        ),
        _vm._v(" "),
        _c(
          "button",
          {
            staticClass: "inline-block py-2 focus:outline-none text-lg",
            class:
              _vm.page_index == "scenario"
                ? "border-b-2 border-vert text-vert font-medium"
                : "text-vN hover:text-black",
            on: {
              click: function($event) {
                _vm.page_index = "scenario"
              }
            }
          },
          [_vm._v("\n                Scénario\n            ")]
        )
      ])
    ]),
    _vm._v(" "),
    _vm.page_index == "indicators"
      ? _c(
          "div",
          { staticClass: "flex" },
          [
            _c("div", { staticClass: "bg-90 bg-white p-6 w-1/2 mr-2" }, [
              _c("div", { staticClass: "mb-6" }, [
                _c("p", { staticClass: "text-left mb-2" }, [
                  _vm._v("Indicateur à modifier:")
                ]),
                _vm._v(" "),
                _c(
                  "select",
                  {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model",
                        value: _vm.selected_indicator,
                        expression: "selected_indicator"
                      }
                    ],
                    staticClass:
                      "w-1/3 form-control form-input form-input-bordered pl-2",
                    on: {
                      change: function($event) {
                        var $$selectedVal = Array.prototype.filter
                          .call($event.target.options, function(o) {
                            return o.selected
                          })
                          .map(function(o) {
                            var val = "_value" in o ? o._value : o.value
                            return val
                          })
                        _vm.selected_indicator = $event.target.multiple
                          ? $$selectedVal
                          : $$selectedVal[0]
                      }
                    }
                  },
                  _vm._l(_vm.indicators, function(indicator) {
                    return _c(
                      "option",
                      {
                        key: indicator.code,
                        domProps: { value: indicator.id }
                      },
                      [
                        _vm._v(
                          "\n                        " +
                            _vm._s(indicator.code) +
                            " |------| " +
                            _vm._s(indicator.name) +
                            "\n                    "
                        )
                      ]
                    )
                  }),
                  0
                )
              ]),
              _vm._v(" "),
              _c("div", { staticClass: "mb-8" }, [
                _c("p", { staticClass: "text-left mb-2" }, [
                  _vm._v("Entreprise:")
                ]),
                _vm._v(" "),
                _c("div", { staticClass: "flex mb-2" }, [
                  _c(
                    "button",
                    { staticClass: "mr-4", on: { click: _vm.checkAllEntrep } },
                    [
                      _vm._v(
                        "\n                        Select all\n                    "
                      )
                    ]
                  ),
                  _vm._v(" "),
                  _c("button", { on: { click: _vm.uncheckAllEntrep } }, [
                    _vm._v(
                      "\n                        Unselect all\n                    "
                    )
                  ])
                ]),
                _vm._v(" "),
                _c(
                  "div",
                  { staticClass: "flex" },
                  _vm._l(_vm.entreprises, function(entreprise, key) {
                    return _c("div", { key: key, staticClass: "flex mr-4" }, [
                      _c("input", {
                        directives: [
                          {
                            name: "model",
                            rawName: "v-model",
                            value: _vm.selected_entreprises,
                            expression: "selected_entreprises"
                          }
                        ],
                        attrs: { id: entreprise.id, type: "checkbox" },
                        domProps: {
                          value: entreprise.id,
                          checked: Array.isArray(_vm.selected_entreprises)
                            ? _vm._i(_vm.selected_entreprises, entreprise.id) >
                              -1
                            : _vm.selected_entreprises
                        },
                        on: {
                          change: function($event) {
                            var $$a = _vm.selected_entreprises,
                              $$el = $event.target,
                              $$c = $$el.checked ? true : false
                            if (Array.isArray($$a)) {
                              var $$v = entreprise.id,
                                $$i = _vm._i($$a, $$v)
                              if ($$el.checked) {
                                $$i < 0 &&
                                  (_vm.selected_entreprises = $$a.concat([$$v]))
                              } else {
                                $$i > -1 &&
                                  (_vm.selected_entreprises = $$a
                                    .slice(0, $$i)
                                    .concat($$a.slice($$i + 1)))
                              }
                            } else {
                              _vm.selected_entreprises = $$c
                            }
                          }
                        }
                      }),
                      _vm._v(" "),
                      _c(
                        "label",
                        {
                          staticClass: "ml-1",
                          attrs: { for: "entreprise.id" }
                        },
                        [_vm._v(" " + _vm._s(entreprise.name) + " ")]
                      )
                    ])
                  }),
                  0
                )
              ]),
              _vm._v(" "),
              _c("div", { staticClass: "flex mb-6" }, [
                _c("div", { staticClass: "mr-8" }, [
                  _c("p", { staticClass: "text-left mb-2 mr-4" }, [
                    _vm._v("Opération:")
                  ]),
                  _vm._v(" "),
                  _c(
                    "select",
                    {
                      directives: [
                        {
                          name: "model",
                          rawName: "v-model",
                          value: _vm.selected_operation,
                          expression: "selected_operation"
                        }
                      ],
                      staticClass:
                        "form-control form-input form-input-bordered pl-2",
                      on: {
                        change: function($event) {
                          var $$selectedVal = Array.prototype.filter
                            .call($event.target.options, function(o) {
                              return o.selected
                            })
                            .map(function(o) {
                              var val = "_value" in o ? o._value : o.value
                              return val
                            })
                          _vm.selected_operation = $event.target.multiple
                            ? $$selectedVal
                            : $$selectedVal[0]
                        }
                      }
                    },
                    _vm._l(_vm.operations, function(op, key) {
                      return _c(
                        "option",
                        { key: key, domProps: { value: op["key"] } },
                        [
                          _vm._v(
                            "\n                            " +
                              _vm._s(op.name) +
                              "\n                        "
                          )
                        ]
                      )
                    }),
                    0
                  )
                ]),
                _vm._v(" "),
                _c("div", { staticClass: "mr-8" }, [
                  _c("p", { staticClass: "text-left mb-2 mr-4" }, [
                    _vm._v("Valeur:")
                  ]),
                  _vm._v(" "),
                  _c("input", {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model.number",
                        value: _vm.operation_value,
                        expression: "operation_value",
                        modifiers: { number: true }
                      }
                    ],
                    staticClass:
                      "form-control form-input form-input-bordered pl-2",
                    attrs: {
                      type: "number",
                      disabled: _vm.selected_operation == "reset"
                    },
                    domProps: { value: _vm.operation_value },
                    on: {
                      input: function($event) {
                        if ($event.target.composing) {
                          return
                        }
                        _vm.operation_value = _vm._n($event.target.value)
                      },
                      blur: function($event) {
                        return _vm.$forceUpdate()
                      }
                    }
                  })
                ])
              ]),
              _vm._v(" "),
              _vm.selected_indicator != null &&
              _vm.selected_entreprises.length > 0
                ? _c(
                    "button",
                    {
                      staticClass: "btn btn-default btn-primary mr-4",
                      on: {
                        click: function($event) {
                          _vm.show_confirmation_modal = true
                        }
                      }
                    },
                    [_vm._v("\n                Send\n            ")]
                  )
                : _vm._e()
            ]),
            _vm._v(" "),
            _vm.show_confirmation_modal
              ? _c("Modal", {
                  staticClass: "pt-44",
                  scopedSlots: _vm._u(
                    [
                      {
                        key: "content",
                        fn: function() {
                          return [
                            _c("div", { staticClass: "flex flex-col gap-2" }, [
                              _c("p", [_vm._v("Confirmer l'action ?")]),
                              _vm._v(" "),
                              _c("div", { staticClass: "flex gap-5" }, [
                                !_vm.update_indicators_sent
                                  ? _c(
                                      "button",
                                      {
                                        staticClass:
                                          "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                        on: { click: _vm.update_indicator }
                                      },
                                      [
                                        _vm._v(
                                          "\n                            Confirmer\n                        "
                                        )
                                      ]
                                    )
                                  : _vm._e(),
                                _vm._v(" "),
                                _c(
                                  "button",
                                  {
                                    staticClass:
                                      "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                    on: {
                                      click: function($event) {
                                        _vm.show_confirmation_modal = false
                                      }
                                    }
                                  },
                                  [
                                    _vm._v(
                                      "\n                            Annuler\n                        "
                                    )
                                  ]
                                )
                              ])
                            ])
                          ]
                        },
                        proxy: true
                      }
                    ],
                    null,
                    false,
                    1886130061
                  )
                })
              : _vm._e(),
            _vm._v(" "),
            _c("div", { staticClass: "bg-90 bg-white p-6 w-1/2" }, [
              _c("div", {}, [
                _c("p", { staticClass: "text-left mb-2" }, [
                  _vm._v("Indicateur à afficher")
                ]),
                _vm._v(" "),
                _c(
                  "select",
                  {
                    directives: [
                      {
                        name: "model",
                        rawName: "v-model",
                        value: _vm.selected_indicator_2,
                        expression: "selected_indicator_2"
                      }
                    ],
                    staticClass:
                      "w-1/3 form-control form-input form-input-bordered pl-2",
                    on: {
                      change: [
                        function($event) {
                          var $$selectedVal = Array.prototype.filter
                            .call($event.target.options, function(o) {
                              return o.selected
                            })
                            .map(function(o) {
                              var val = "_value" in o ? o._value : o.value
                              return val
                            })
                          _vm.selected_indicator_2 = $event.target.multiple
                            ? $$selectedVal
                            : $$selectedVal[0]
                        },
                        _vm.getEntrepriseIndicators
                      ]
                    }
                  },
                  _vm._l(_vm.indicators, function(indicator) {
                    return _c(
                      "option",
                      {
                        key: indicator.code,
                        domProps: { value: indicator.id }
                      },
                      [
                        _vm._v(
                          "\n                        " +
                            _vm._s(indicator.code) +
                            " |------| " +
                            _vm._s(indicator.name) +
                            "\n                    "
                        )
                      ]
                    )
                  }),
                  0
                )
              ]),
              _vm._v(" "),
              _vm.indicator_2_loaded
                ? _c("table", { staticClass: "mt-4 w-full" }, [
                    _vm._m(0),
                    _vm._v(" "),
                    _c(
                      "tbody",
                      _vm._l(_vm.data, function(datum) {
                        return _c("tr", { key: datum.id }, [
                          _c(
                            "th",
                            {
                              staticClass:
                                "p-3 font-bold text-gray-600 border border-gray-300  "
                            },
                            [
                              _vm._v(
                                "\n                            " +
                                  _vm._s(datum.name) +
                                  "\n                        "
                              )
                            ]
                          ),
                          _vm._v(" "),
                          _c(
                            "th",
                            {
                              staticClass:
                                "p-3 font-bold text-gray-600 border border-gray-300 "
                            },
                            [
                              _vm._v(
                                "\n                            " +
                                  _vm._s(datum.value) +
                                  "\n                        "
                              )
                            ]
                          )
                        ])
                      }),
                      0
                    )
                  ])
                : _vm._e()
            ])
          ],
          1
        )
      : _vm._e(),
    _vm._v(" "),
    _vm.page_index == "settings"
      ? _c(
          "div",
          { staticClass: "flex justify-center" },
          [_c("GameSettings")],
          1
        )
      : _vm._e(),
    _vm._v(" "),
    _vm.page_index == "scenario"
      ? _c(
          "div",
          { staticClass: "justify-center" },
          [
            _c("div", { staticClass: "mb-6" }, [
              !_vm.reset_game_sent
                ? _c(
                    "button",
                    {
                      staticClass:
                        "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                      on: {
                        click: function($event) {
                          _vm.show_reset_game_modal = true
                        }
                      }
                    },
                    [_vm._v("\n                Reset game\n            ")]
                  )
                : _vm._e()
            ]),
            _vm._v(" "),
            _c("p", { staticClass: "text-left mb-2" }, [_vm._v("Scénario:")]),
            _vm._v(" "),
            _c("div", { staticClass: "mb-6 flex" }, [
              _c(
                "select",
                {
                  directives: [
                    {
                      name: "model",
                      rawName: "v-model",
                      value: _vm.selected_scenario,
                      expression: "selected_scenario"
                    }
                  ],
                  staticClass:
                    "w-1/3 form-control form-input form-input-bordered pl-2",
                  on: {
                    change: function($event) {
                      var $$selectedVal = Array.prototype.filter
                        .call($event.target.options, function(o) {
                          return o.selected
                        })
                        .map(function(o) {
                          var val = "_value" in o ? o._value : o.value
                          return val
                        })
                      _vm.selected_scenario = $event.target.multiple
                        ? $$selectedVal
                        : $$selectedVal[0]
                    }
                  }
                },
                _vm._l(_vm.scenarios, function(scenario, key) {
                  return _c(
                    "option",
                    { key: key, domProps: { value: scenario } },
                    [
                      _vm._v(
                        "\n                    " +
                          _vm._s(scenario) +
                          "\n                "
                      )
                    ]
                  )
                }),
                0
              ),
              _vm._v(" "),
              !_vm.change_scenario_sent
                ? _c(
                    "button",
                    {
                      staticClass:
                        "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                      on: {
                        click: function($event) {
                          _vm.show_change_scenario_modal = true
                        }
                      }
                    },
                    [_vm._v("\n                Change scenario\n            ")]
                  )
                : _vm._e()
            ]),
            _vm._v(" "),
            _vm.show_reset_game_modal
              ? _c("Modal", {
                  staticClass: "pt-44",
                  scopedSlots: _vm._u(
                    [
                      {
                        key: "content",
                        fn: function() {
                          return [
                            _c("div", { staticClass: "flex flex-col gap-2" }, [
                              _c("p", [_vm._v("Réinitialiser le jeu ?")]),
                              _vm._v(" "),
                              _c("input", {
                                directives: [
                                  {
                                    name: "model",
                                    rawName: "v-model",
                                    value: _vm.password,
                                    expression: "password"
                                  }
                                ],
                                attrs: {
                                  type: "text",
                                  placeholder: "Mot de passe"
                                },
                                domProps: { value: _vm.password },
                                on: {
                                  input: function($event) {
                                    if ($event.target.composing) {
                                      return
                                    }
                                    _vm.password = $event.target.value
                                  }
                                }
                              }),
                              _vm._v(" "),
                              _c(
                                "div",
                                { staticClass: "flex gap-5 justify-center" },
                                [
                                  _vm.password == _vm.correct_password
                                    ? _c(
                                        "button",
                                        {
                                          staticClass:
                                            "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                          on: { click: _vm.resetGame }
                                        },
                                        [
                                          _vm._v(
                                            "\n                            Confirmer\n                        "
                                          )
                                        ]
                                      )
                                    : _vm._e(),
                                  _vm._v(" "),
                                  _c(
                                    "button",
                                    {
                                      staticClass:
                                        "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                      on: {
                                        click: function($event) {
                                          _vm.show_reset_game_modal = false
                                        }
                                      }
                                    },
                                    [
                                      _vm._v(
                                        "\n                            Annuler\n                        "
                                      )
                                    ]
                                  )
                                ]
                              )
                            ])
                          ]
                        },
                        proxy: true
                      }
                    ],
                    null,
                    false,
                    1843680636
                  )
                })
              : _vm._e(),
            _vm._v(" "),
            _vm.show_change_scenario_modal
              ? _c("Modal", {
                  staticClass: "pt-44",
                  scopedSlots: _vm._u(
                    [
                      {
                        key: "content",
                        fn: function() {
                          return [
                            _c("div", { staticClass: "flex flex-col gap-2" }, [
                              _c("p", [
                                _vm._v(
                                  "Lancer le scénario " +
                                    _vm._s(_vm.selected_scenario) +
                                    " ?"
                                )
                              ]),
                              _vm._v(" "),
                              _c("input", {
                                directives: [
                                  {
                                    name: "model",
                                    rawName: "v-model",
                                    value: _vm.password,
                                    expression: "password"
                                  }
                                ],
                                attrs: {
                                  type: "text",
                                  placeholder: "Mot de passe"
                                },
                                domProps: { value: _vm.password },
                                on: {
                                  input: function($event) {
                                    if ($event.target.composing) {
                                      return
                                    }
                                    _vm.password = $event.target.value
                                  }
                                }
                              }),
                              _vm._v(" "),
                              _c(
                                "div",
                                { staticClass: "flex gap-5 justify-center" },
                                [
                                  _vm.password == _vm.correct_password
                                    ? _c(
                                        "button",
                                        {
                                          staticClass:
                                            "bg-green-600 rounded-md px-3 border-2 border-green-600 py-1 text-white",
                                          on: { click: _vm.changeScenario }
                                        },
                                        [
                                          _vm._v(
                                            "\n                            Confirmer\n                        "
                                          )
                                        ]
                                      )
                                    : _vm._e(),
                                  _vm._v(" "),
                                  _c(
                                    "button",
                                    {
                                      staticClass:
                                        "bg-white border-vert border-2 rounded-md px-3 py-1 text-black",
                                      on: {
                                        click: function($event) {
                                          _vm.show_change_scenario_modal = false
                                        }
                                      }
                                    },
                                    [
                                      _vm._v(
                                        "\n                            Annuler\n                        "
                                      )
                                    ]
                                  )
                                ]
                              )
                            ])
                          ]
                        },
                        proxy: true
                      }
                    ],
                    null,
                    false,
                    3929752366
                  )
                })
              : _vm._e()
          ],
          1
        )
      : _vm._e()
  ])
}
var staticRenderFns = [
  function() {
    var _vm = this
    var _h = _vm.$createElement
    var _c = _vm._self._c || _h
    return _c("thead", [
      _c("tr", [
        _c(
          "th",
          {
            staticClass:
              "w-1/3 p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300  "
          },
          [
            _vm._v(
              "\n                            Entreprise\n                        "
            )
          ]
        ),
        _vm._v(" "),
        _c(
          "th",
          {
            staticClass:
              "p-3 font-bold uppercase bg-gray-200 text-gray-600 border border-gray-300 "
          },
          [
            _vm._v(
              "\n                            Valeur\n                        "
            )
          ]
        )
      ])
    ])
  }
]
render._withStripped = true
module.exports = { render: render, staticRenderFns: staticRenderFns }
if (false) {
  module.hot.accept()
  if (module.hot.data) {
    require("vue-hot-reload-api")      .rerender("data-v-68ff5483", module.exports)
  }
}

/***/ }),
/* 26 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })
/******/ ]);
