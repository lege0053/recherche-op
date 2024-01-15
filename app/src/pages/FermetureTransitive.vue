<script setup lang="js">
import axios from 'axios';
import { ref, onMounted } from 'vue';
import {createGraphFromMatrix } from "../utils/createGraphFromMatrix"

// fonction exécutant le script Lua via une requête HTTP
const runLuaScript = async () => {
  try {
    const res = await axios.post('http://localhost:3000/', {
      script: 'fermeture_transitive',
      data: { "matrice": adjacencyMatrix },
    });   
    return res.data.result
  } catch (error) {
    console.error('Error calling the Lua script:', error);
  }
};

const res = ref(null)

// Appelle la fonction runLuaScript au moment du montage du composant
onMounted(async () => {
  res.value = await runLuaScript();
});

// Matrice d'adjacence représentant le graphe
const adjacencyMatrix = [
  [0, 0, 0, 0, 0],
  [1, 0, 0, 0, 0],
  [0, 1, 0, 1, 0],
  [1, 0, 0, 0, 1],
  [0, 0, 1, 0, 0],
];
// Appelle la fonction createGraphFromMatrix pour obtenir les données du graphe
const { nodes, edges, layouts, configs } = createGraphFromMatrix(adjacencyMatrix);
const matrixText = matrixToText(adjacencyMatrix)

function matrixToText(matrix) {
  return matrix.map(row => `[${row.join(', ')}]`).join(',\n')
}
</script>

<template>
  <q-page class="q-pa-lg">
    <h5 class="q-mt-none">Fermeture transitive</h5>

    <!-- Matrice initial -->
    <h6 class="q-mb-md">Matrice initial</h6>

    <q-input
      v-model="matrixText"
      label="Matrice d'adjacence initiale"
      autogrow
      outlined
      readonly
    />

    <div class="graphContainer">
      <v-network-graph 
        class="graph"
        :nodes="nodes" 
        :edges="edges" 
        :layouts="layouts" 
        :configs="configs" 
      />
    </div>
    
    <!-- Graph de fermeture transitive-->
    <h6 class="q-mb-md">Matrice de fermeture transitive</h6>
    <q-input
      v-if="res"
      v-model="res"
      label="Matrice de fermeture transitive"
      autogrow
      outlined
      readonly
    />
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