<script setup lang="js">
import axios from 'axios';
import { ref, onMounted } from 'vue';
import {createGraphFromMatrix } from "../utils/createGraphFromMatrix"

// fonction exécutant le script Lua via une requête HTTP
const runLuaScript = async () => {
  try {
    const response = await axios.post('http://localhost:3000/', {
      script: 'parcours_largeur', // Nom exact du script Lua à exécuter (/api/scripts/)
      data: { "matrice": adjacencyMatrix },
    });
    // Transforme le résultat en tableau correspondant au différent print() du script Lua
    return response.data.result.split('\r\n')
  } catch (error) {
    console.error('Error calling the Lua script:', error);
  }
};

const res = ref('')

// Appelle la fonction runLuaScript au moment du montage du composant
onMounted(async () => {
  res.value = await runLuaScript();
});

// Matrice d'adjacence représentant le graphe
const adjacencyMatrix = [
  [0, 1, 1, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 1, 0],
  [0, 0, 1, 0, 0, 0],
  [0, 0, 0, 1, 0, 1],
  [0, 1, 0, 0, 0, 0],
];
// Appelle la fonction createGraphFromMatrix pour obtenir les données du graphe
const { nodes, edges, layouts, configs } = createGraphFromMatrix(adjacencyMatrix);

const matrixText = adjacencyMatrix.map(row => `[${row.join(', ')}]`).join(',\n')
</script>

<template>
  <q-page class="q-pa-lg">
    <h5 class="q-mt-none">Parcours en largeur </h5>

    <q-input
      v-model="matrixText"
      label="Matrice d'adjacence"
      autogrow
      outlined
      readonly
    />

    <!-- Graph -->
    <div class="graphContainer">
      <v-network-graph 
        class="graph"
        :nodes="nodes" 
        :edges="edges" 
        :layouts="layouts" 
        :configs="configs" 
      />
    </div>
    <!-- Résultat du script Lua -->
    <p>{{ res[0] }}</p>
    <p>{{ res[1] }}</p>
  </q-page>
</template>

<style>
.graphContainer {
  height: 300px;
}
.graph {
  height: 100%;
}
</style>