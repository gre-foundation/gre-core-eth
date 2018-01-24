var HazardCategory = artifacts.require("HazardCategory");
// var HazardIdentification = artifacts.require("HazardIdentification");
var Oracle = artifacts.require("Oracle");
var CentralizedHumanResolutionOracle = artifacts.require("CentralizedHumanResolutionOracle");
var Policy = artifacts.require("Policy");

module.exports = function(deployer, network, accounts) {
    var address = accounts[0];
    deployer.deploy(HazardCategory);

    deployer.deploy(CentralizedHumanResolutionOracle,address).then(function() {
        deployer.deploy(Policy,CentralizedHumanResolutionOracle.address,1,10);
    });

    
}