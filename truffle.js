var bip39 = require("bip39");
var hdkey = require('ethereumjs-wallet/hdkey');
var ProviderEngine = require("web3-provider-engine");
var WalletSubprovider = require('web3-provider-engine/subproviders/wallet.js');
var Web3Subprovider = require("web3-provider-engine/subproviders/web3.js");
var Web3 = require("web3");

// Get our mnemonic and create an hdwallet
var mnemonic = "temple unique issue wine jumping hairy foot onomatopoeia forever twenty one";
var hdwallet = hdkey.fromMasterSeed(bip39.mnemonicToSeed(mnemonic));

// Get the first account using the standard hd path.
var wallet_hdpath = "m/44'/60'/0'/0/";
var wallet = hdwallet.derivePath(wallet_hdpath + "0").getWallet();
var address = "0x" + wallet.getAddress().toString("hex");

var providerUrl = "https://morden.infura.io:8545";
var engine = new ProviderEngine();
engine.addProvider(new WalletSubprovider(wallet, {}));
engine.addProvider(new Web3Subprovider(new Web3.providers.HttpProvider(providerUrl)));
engine.start(); // Required by the provider engine.

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
   networks: {
    "morden": {
      network_id: 2,    // Official morden network id
      provider: engine, // Use our custom provider
      from: address     // Use the address we derived
    }
  },
  rpc: {
    host: "localhost",
    port: 8545
  }
};
