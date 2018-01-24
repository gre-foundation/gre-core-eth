"use strict";
var CentralizedHumanResolutionOracle = artifacts.require('CentralizedHumanResolutionOracle');
contract('TestContract', function(accounts) {

    var oracleInstance = null;
    beforeEach('setup contract for each test', async() => {
        CentralizedHumanResolutionOracle.deployed().then(function(instance) {
            oracleInstance = instance;
        });
    });
    
    it('should owner have permission to set result', async() => {
        return CentralizedHumanResolutionOracle.deployed().then(function(instance) {
            oracleInstance = instance;
            return oracleInstance.resolve.call(1);
          }).then(function(result) {
            assert.equal(result.valueOf(), true);
          });
    });
})