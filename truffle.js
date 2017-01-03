module.exports = {
  build: {
    "index.html": "index.html",
    "app.js": [
      "javascripts/toolkit.js",
      "javascripts/ipfs-helper.js",
      "javascripts/app.js"
    ],
    "app.css": [
      "stylesheets/app.css"
    ],
    "images/": "images/"
  },
  rpc: {
    host: "localhost",
    port: 8545
  }
};
