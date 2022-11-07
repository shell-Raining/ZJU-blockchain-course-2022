<script setup>
import { ref } from 'vue';
import { computed } from 'vue';
import { voteContract, zjcoinContract } from './utils/contracts';

const GanacheTestChainId = '0x539';
const GanacheTestChainName = 'Ganache Test Chain';
const GanacheTestChainRpcUrl = 'http://127.0.0.1:8545';
const currentAccount = ref();
const remain = ref('?');
const connected = computed(() => {
  return currentAccount.value != undefined;
});

const connectWallet = async () => {
  const { ethereum } = window;
  if (!Boolean(ethereum && ethereum.isMetaMask)) {
    alert('metamask is not installed');
    return;
  }

  if (connected) {
    console.log('already connected');
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    currentAccount.value = accounts[0];
    return;
  }

  try {
    if (ethereum.chainId !== GanacheTestChainId) {
      const chain = {
        chainId: GanacheTestChainId,
        chainName: GanacheTestChainName,
        rpcUrls: [GanacheTestChainRpcUrl],
      };

      try {
        await ethereum.request({
          method: 'wallet_switchEthereumChain',
          params: [{ chainId: chain.chainId }],
        });
      } catch (switchError) {
        if (switchError.code === 4902) {
          await ethereum.request({ method: 'wallet_addEthereumChain', params: [chain] });
        }
      }
    }

    await ethereum.request({ method: 'eth_requestAccounts' });
  } catch (error) {
    alert(error.message);
  }
};

const getRemain = async () => {
  remain.value = await zjcoinContract.methods.balanceOf(currentAccount.value).call();
  console.log("getRemain");
};

const addProposal = async () => {
  let res = await voteContract.methods.addProposal('hello world').call({ from: currentAccount.value });
  if (res) {
    console.log("add successfully");
  }else {
    console.log("add failed");
  }
};

ethereum.on('accountsChanged', async () => {
  const accounts = await ethereum.request({ method: 'eth_accounts' });
  currentAccount.value = accounts[0];
});
</script>

<template>
  <header><h1>this is zju blockchain homework</h1></header>
  <main>
    <!-- connect section -->
    <div v-if="!connected">
      <div>please connect to your wallet</div>
      <button @click="connectWallet">connect</button>
    </div>
    <div v-else>
      <div>the address of your account is {{ currentAccount }}</div>
      <!-- proposal info section -->
      <button @click="getRemain">get remain zjcoin</button>
      <div>the remain zjcoin is {{ remain }}</div>

      <!-- add proposal -->
      <button @click="addProposal">add proposal</button>
    </div>
  </main>
</template>

<style scoped></style>
