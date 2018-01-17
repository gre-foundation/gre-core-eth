var HazardCategory = artifacts.require("HazardCategory");
var HazardIdentification = artifacts.require("HazardIdentification");

module.exports = function(deployer) {
    deployer.deploy(HazardCategory);

    deployer.deploy(HazardIdentification);
}