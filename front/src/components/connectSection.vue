<script setup>
import { computed } from 'vue';
import { ref } from 'vue';

const GanacheTestChainId = '0x539';
const GanacheTestChainName = 'Ganache Test Chain';
const GanacheTestChainRpcUrl = 'http://127.0.0.1:8545';
const currentAccount = ref();
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

ethereum.on('accountsChanged', async () => {
  const accounts = await ethereum.request({ method: 'eth_accounts' });
  currentAccount.value = accounts[0];
});
</script>

<template>
  <div v-if="currentAccount == undefined">
    <div>please connect to your wallet</div>
    <button @click="connectWallet">connect</button>
  </div>
  <div v-else>
    <div>the address of your account is {{ currentAccount }}</div>
  </div>
</template>
