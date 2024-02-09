<script setup lang="js">
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { createGraphFromMatrix } from "../utils/createGraphFromMatrix";

// Fonction exécutant le script Lua via une requête HTTP
const runLuaScript = async (matrix) => {
  try {
    const response = await axios.post('http://localhost:3000/', {
      script: 'ford_max',
      data: { "matrice": matrix },
    });
    // Transforme le résultat en tableau correspondant aux différents print() du script Lua
    return response.data.result.split('\r\n');
  } catch (error) {
    console.error('Error calling the Lua script:', error);
  }
};

// Matrice d'adjacence représentant le graphe
const originalAdjacencyMatrix = ref([
  [0, 5, 2, 0, 10, 0],
  [0, 0, 0, 8, 0, 3],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 8],
  [0, 0, 0, 2, 0, 0],
]);

const res = ref([]);
const nodes = ref([]);
const edges = ref([]);
const layouts = ref([]);
const configs = ref([]);

async function updateGraph(){
  const result = createGraphFromMatrix(originalAdjacencyMatrix.value, true);
  nodes.value = result.nodes;
  edges.value = result.edges;
  layouts.value = result.layouts;
  configs.value = result.configs;
  res.value = await runLuaScript(originalAdjacencyMatrix.value);
};
// Appelle la fonction runLuaScript au moment du montage du composant
onMounted(async () => {
  await updateGraph();
});

</script>

<template>
  <q-page class="q-pa-lg">
    <h5 class="q-mt-none">Ford (coût maximum)</h5>

    <!-- Conteneur principal avec flexbox -->
    <div class="container">

      <!-- Partie gauche : Matrice d'adjacence et Graph -->
      <div class="left">

      <!-- Matrice -->
      <p class="title">Matrice</p>
      <div class="matrix-input">
        <div v-for="(row, rowIndex) in originalAdjacencyMatrix" :key="rowIndex" class="matrix-row">
          <div v-for="(value, colIndex) in row" :key="colIndex" class="matrix-cell">
            <q-input v-model="originalAdjacencyMatrix[rowIndex][colIndex]" type="number" outlined dense />
          </div>
        </div>
        <q-btn @click="updateGraph" label="Update Graph" />
      </div>

      <!-- Graph -->
      <div class="graphContainer">
        <v-network-graph 
          class="graph"
          :nodes="nodes" 
          :edges="edges" 
          :layouts="layouts" 
          :configs="configs">

          <template #edge-label="{ edge, ...slotProps }">
            <v-edge-label
              :text="edge.label"
              align="center"
              vertical-align="above"
              v-bind="slotProps"
            />
          </template>
        </v-network-graph> 
      </div>
    </div>

    <!-- Partie droite : Résultat du script Lua -->
    <div  class="right">
      <p class="title">Resultats</p>
      <p v-for="(result, index) in res" :key="index">{{ result }}</p>
    </div>
  </div>
  </q-page>
</template>

<style>
.title {
  font-size:15pt; 
  font-weight: 600; 
  color: #3355BB;
}

.container {
  display: flex;
}

.left {
  flex: 1;
  margin-right: 20px;
}

.graphContainer {
  height: 300px;
}

.graph {
  height: 100%;
}

.right {
  flex: 1;
}

.matrix-input {
  margin-top: 20px;
}

.matrix-row {
  display: flex;
  margin-bottom: 5px;
}

.matrix-cell {
  margin-right: 5px;
}
</style>
