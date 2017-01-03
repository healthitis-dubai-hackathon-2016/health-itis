(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.Tools = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function() {
var ipfs = {};
ipfs.localProvider = {host: '127.0.0.1', port: '5001', protocol: 'http', root: '/api/v0'};

ipfs.setProvider = function(opts) {
  if (!opts) opts = this.localProvider;
  if (typeof opts === 'object' && !opts.hasOwnProperty('host')) {
    return;
  }
  ipfs.api = opts;
};

ipfs.api_url = function(path) {
  var api = ipfs.api;
  return api.protocol + "://" + api.host +
          (api.port ? ":" + api.port :"")  +
          (api.root ? api.root :"") + path;
}

function ensureProvider(callback) {
  if (!ipfs.api) {
    callback("No provider set", null);
    return false;
  }
  return true;
}

function request(opts) {
  if (!ensureProvider(opts.callback)) return ;
  var req = new XMLHttpRequest();
  req.onreadystatechange = function() {
    if (req.readyState == 4) {
      if (req.status != 200)
        opts.callback(req.responseText,null);
      else {
        var response = req.responseText;
        if (opts.transform) {
          response = opts.transform(response);
        }
        opts.callback(null,response);
      }
    }
  };
  req.open(opts.method || "GET", ipfs.api_url(opts.uri));
  if (opts.accept) {
    req.setRequestHeader("accept", opts.accept);
  }
  if (opts.payload) {
    req.enctype = "multipart/form-data";
    req.send(opts.payload);
  } else {
    req.send()
  }
}

ipfs.add = function(input, callback) {
  var form = new FormData();
  var data = (isBuffer(input) ? input.toString('binary') : input);
  var blob = new Blob([data],{})
  form.append("file", blob);
  request({
    callback: callback,
    method:"POST",
    uri:"/add",
    payload:form,
    accept: "application/json",
    transform: function(response) { return response ? JSON.parse(response)["Hash"] : null}});
};

ipfs.catText = function(ipfsHash, callback) {
  request({callback: callback, uri:("/cat/" + ipfsHash)})
};

ipfs.cat = ipfs.catText; // Alias this for now

ipfs.addJson = function(jsonObject, callback) {
  var jsonString = JSON.stringify(jsonObject);
  ipfs.add(jsonString, callback);
};

ipfs.catJson = function(ipfsHash, callback) {
  ipfs.catText(ipfsHash, function (err, jsonString) {
    if (err) callback(err, {});
    var jsonObject = {};
    try {
      jsonObject = typeof jsonString === 'string' ?  JSON.parse(jsonString) : jsonString;
    } catch (e) {
      err = e;
    }
    callback(err, jsonObject);
  });
};

// From https://github.com/feross/is-buffer
function isBuffer(obj) {
  return !!(obj != null &&
    (obj._isBuffer || // For Safari 5-7 (missing Object.prototype.constructor)
      (obj.constructor &&
      typeof obj.constructor.isBuffer === 'function' &&
      obj.constructor.isBuffer(obj))
    ))
}

if (typeof window !== 'undefined') {
  window.ipfs = ipfs;
}
if (typeof module !== 'undefined' && module.exports) {
  module.exports = ipfs;
}
})();

},{}],2:[function(require,module,exports){
var ipfs = require('browser-ipfs');

module.exports = {
  ipfs: ipfs
}

},{"browser-ipfs":1}]},{},[2])(2)
});