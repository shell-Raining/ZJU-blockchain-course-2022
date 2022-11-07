import  Vote  from './abis/Vote.json';
import  Zjcoin  from './abis/Zjcoin.json';
import address from './contract_address.json';
import Web3 from 'web3';

// 获取合约实例
// const web3 = new Web3(window.web3.currentProvider);
const web3 = new Web3(Web3.givenProvider);
const voteContract = new web3.eth.Contract(Vote.abi, address.voteAddr);
const zjcoinContract = new web3.eth.Contract(Zjcoin.abi, address.zjcoinAddr);

// 导出web3实例和其它部署的合约
export { voteContract, zjcoinContract };
