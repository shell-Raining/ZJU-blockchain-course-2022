# ZJU-blockchain-course-2022

## 运行

1. 在本地启动 ganache 应用。

2. 在 `./contracts` 中安装需要的依赖，运行如下的命令：
   ```bash
   npm install
   ```
3. 在 `./contracts` 中部署合约，运行如下的命令：
   ```bash
   truffle migrate
   ```
4. 在 `./front/` 中安装依赖
   ```bash
   npm install
   ```
5. 在 `./frontend` 中启动前端程序，运行如下的命令：
   ```bash
   npm run dev
   ```

## 功能实现分析

前后端实现了连接钱包，获取指定数量的代币，消耗指定数量的代币进行添加提案的功能。

后端实现了获取提案列表的功能，给指定提案投票的功能，但是前端没有实现

## 参考内容

[metamask](https://docs.metamask.io/guide/ethereum-provider.html#table-of-contents)

[we3.js](https://web3js.readthedocs.io/en/v1.2.11/web3-eth-contract.html)

[智能合约](https://ethereum.org/zh/developers/docs/smart-contracts/)
