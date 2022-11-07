var vote = artifacts.require("Vote");
var zjcoin = artifacts.require("Zjcoin");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(vote);
  deployer.deploy(zjcoin);
};