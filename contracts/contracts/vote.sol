// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Zjcoin.sol";

contract Vote {
    uint256 public constant PROP_TIP = 3;
    uint256 public constant VOTE_TIP = 1;
    Zjcoin zjcoin;

    constructor() {
        zjcoin = new Zjcoin();
    }

    struct Proposal {
        address author;
        string content;
        uint256 agreeNum;
        uint256 disagreeNum;
    }

    Proposal[] proposalList;

    function addProposal(string calldata content) external returns (bool) {
        Proposal memory newProposal;
        newProposal.content = content;
        newProposal.author = msg.sender;
        proposalList.push(newProposal);
        
        if(zjcoin.burn(msg.sender, PROP_TIP)){
            return true;
        }
        return false;
    }

    function getPorpList() external view returns (Proposal[] memory) {
        return proposalList;
    }

    function vote(uint256 index, bool support) external returns (bool) {
        uint256 size = proposalList.length;
        if (index >= size) {
            return false;
        }

        if (support) {
            proposalList[index].agreeNum++;
        } else {
            proposalList[index].disagreeNum++;
        }
        if(zjcoin.burn(msg.sender, VOTE_TIP)){
            return true;
        }
        return false;
    }
}
