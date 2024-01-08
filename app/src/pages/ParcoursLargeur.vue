<script setup lang="js">
// Import de la bibliothèque lua.vm.js
// import * as luavm from 'lua.vm.js';

// const l = new luavm.Lua.State();
// const res = l.execute('print("Hello, world")');
import axios from 'axios';

const runLuaScript = async () => {
  try {
    // Effectuer une requête POST pour exécuter le script Lua
    const response = await axios.post('http://localhost:3000/parcours_largeur', {
      script: 'parcours_largeur.lua',
      data: { key: 'value' }, // Les données que vous souhaitez envoyer au script Lua
    });

    console.log(response.data); // Cela devrait afficher "hello world" dans la console
    // Faites quelque chose avec le résultat, par exemple, mettez à jour l'état du composant
  } catch (error) {
    console.error('Error calling the Lua script:', error);
  }
};

// Utilisation de runLuaScript
runLuaScript();
</script>

<template>
  <q-page class="q-pa-lg">
  <h5 class="q-mt-none">Parcous en largeur </h5>
  </q-page>
</template>

