pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/HazardCategory.sol";

contract TestHazardCategory {
    HazardCategory hazardCategory = HazardCategory(DeployedAddresses.HazardCategory());

    // Testing the setCategory() function
    function testCreatorCanSetCategory() public {
        bool result = hazardCategory.setCategory(1,10000);

        bool excepted = true;

        Assert.equal(result,excepted, "Set category should be recorded.");
    }

    // Testing retrieval of a single category
    function testGetCategoryByIndex() public {
        uint category = hazardCategory.categories(1);

        uint excepted = 10000;

        Assert.equal(category, excepted, "Code of category 1 should be 10000.");
    }
    
    // Testing retrieval of all categories
    function testGetAllCategories() public {
        // Store categories in memory rather than contract's storage
        uint[256] memory categories = hazardCategory.getCategories();

        uint excepted = 10000;

        Assert.equal(categories[1], excepted, "Code of category 1 should be 10000.");
    }

    function testSetSubCategory() public {
        bool result = hazardCategory.setSubCategory(1,0,10001);

        bool excepted = true;

        Assert.equal(result,excepted, "Set sub category should be recorded.");
    }

    function testSetSubCategoryWithArray() public {
        uint[256] memory subCategories;
        uint code = 10001;
        subCategories[0] = code;
        bool result = hazardCategory.setSubCategory(1,subCategories);

        bool excepted = true;
        Assert.equal(result,excepted, "Set sub category should be recorded.");
    }

    // Testing retrieval of a single sub category
    function testGetSubCategoryByIndex() public {
        uint subCategory = hazardCategory.subCategories(1,0);

        uint excepted = 10001;

        Assert.equal(subCategory, excepted, "Code of sub category 1,0 should be 10001.");
    }

    // Testing retrieval of a single sub category
    function testGetSubCategoryList() public {
        uint[256] memory subCategories = hazardCategory.getSubCategories(1);

        uint excepted = 10001;

        Assert.equal(subCategories[0], excepted, "Code of sub category 1,0 should be 10001.");
    }
}