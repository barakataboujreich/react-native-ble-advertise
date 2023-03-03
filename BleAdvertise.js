"use strict";
var React = require("react-native");
var bleAdvertise = React.NativeModules.BleAdvertise;

class BleAdvertise {
  constructor() {
  }

  broadcast(uuid, myMajor, myMinor) {
    return new Promise((fulfill, reject) => {
        bleAdvertise.broadcast(uuid, myMajor, myMinor)
                .then(success => {
                    fulfill(success);
                }).catch(error => {
                    reject(error);
                 });
    });
  }

  stopBroadcast() {
    return new Promise((fulfill, reject) => {
        bleAdvertise.stopBroadcast().then(success => { 
            fulfill(success);
        }).catch(error => {
            reject(error);
         });
    });
  }

  checkIfBLESupported() {
    return new Promise((fulfill, reject) => {
        bleAdvertise.checkIfBLESupported().then((code) => {
            fulfill(code);
        }).catch((ex) => {
            reject(ex);
        });
    });
  }

  setCompanyId(companyID) {
    bleAdvertise.setCompanyId(companyID);
  }
}

module.exports = new BleAdvertise();
