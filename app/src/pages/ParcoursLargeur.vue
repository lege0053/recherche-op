<script setup lang="js">
import axios from 'axios';
import { ref, onMounted } from 'vue';

const runLuaScript = async () => {
  try {
    // Effectuer une requête POST pour exécuter le script Lua
    const response = await axios.post('http://localhost:3000/', {
      script: 'parcours_largeur', // nom exact du script
      data: { makey: 'mavaleur', makey2: 'maval2' },
    });

    console.log("res=",response.data.result);
    return response.data.result
  } catch (error) {
    console.error('Error calling the Lua script:', error);
  }
};

// Utilisation de runLuaScript
const res = ref(null)

onMounted(async () => {
  res.value = await runLuaScript();
});
</script>

<template>
  <q-page class="q-pa-lg">
  <h5 class="q-mt-none">Parcours en largeur </h5>
  <p>{{ res }}</p>
  </q-page>
</template>

