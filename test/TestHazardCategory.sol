pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HazardCategory.sol";

contract TestHazardCategory {
    HazardCategory hazardCategory = HazardCategory(DeployedAddresses.HazardCategory());

    // Testing the setCategory() function
    function testCreatorCanSetCategory() public {
        uint categoryId = hazardCategory.setCategory(1,10000);

        uint excepted = 1;

        Assert.equal(categoryId,excepted, "Add new category should be recorded.");
    }

    // Testing retrieval of a single category
    function testGetCategoryByIndex() public {
        uint category = hazardCategory.categories(1);

        uint excepted = 10000;

        Assert.equal(category, excepted, "Code of category 0 should be 10000.");
    }
    
    // Testing retrieval of all categories
    function testGetAllCategories() public {
        // Store categories in memory rather than contract's storage
        uint[256] memory categories = hazardCategory.getCategories();

        uint excepted = 10000;

        Assert.equal(categories[1], excepted, "Code of category 0 should be 10000.");
    }
}