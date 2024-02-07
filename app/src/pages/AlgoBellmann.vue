<template>
  <q-page class="q-pa-lg">
    <h5 class="q-mt-none">Bellmann</h5>

    <!-- Conteneur principal avec flexbox -->
    <div class="container">

      <!-- Partie gauche : Matrice d'adjacence et Graph -->
      <div class="left">
        <q-input
          v-model="matrixText"
          label="Matrice d'adjacence"
          autogrow
          outlined
          readonly
        />

        <!-- Matrix Input for Modification -->
        <div class="matrix-input">
          <div v-for="(row, rowIndex) in adjacencyMatrix" :key="rowIndex" class="matrix-row">
            <div v-for="(value, colIndex) in row" :key="colIndex" class="matrix-cell">
              <q-input v-model="adjacencyMatrix[rowIndex][colIndex]" type="number" outlined dense />
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
        <p style="font-size:15pt ; font-weight: 600; color: #3355BB;" >Resultats</p>
        <p v-for="(result, index) in res" :key="index">{{ result }}</p>
      </div>

    </div>

  </q-page>
</template>

<script setup lang="js">
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { createGraphFromMatrix } from "../utils/createGraphFromMatrix";

// Define runLuaScript function
const runLuaScript = async (matrix) => {
  try {
    const response = await axios.post('http://localhost:3000/', {
      script: 'bellmann',
      data: { "matrice": matrix },
    });
    return response.data.result.split('\r\n');
  } catch (error) {
    console.error('Error calling the Lua script:', error);
  }
};

const originalAdjacencyMatrix = [
  [0, 5, 2, 0, 10, 0],
  [0, 0, 0, 8, 0, 3],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 8],
  [0, 0, 0, 2, 0, 0],
];
const adjacencyMatrix = JSON.parse(JSON.stringify(originalAdjacencyMatrix));

const res = ref('');
const{ nodes, edges, layouts, configs } = createGraphFromMatrix(originalAdjacencyMatrix, true);
let matrixText = adjacencyMatrix.map(row => `[${row.join(', ')}]`).join(',\n');

const updateGraph = async () => {
  adjacencyMatrix.forEach((row, rowIndex) => {
    row.forEach((value, colIndex) => {
      adjacencyMatrix[rowIndex][colIndex] = parseFloat(adjacencyMatrix[rowIndex][colIndex]);
    });
  });

   createGraphFromMatrix(adjacencyMatrix, true);
  

  res.value = await runLuaScript(adjacencyMatrix);
  matrixText = adjacencyMatrix.map(row => `[${row.join(', ')}]`).join(',\n');
};


onMounted(async () => {
  res.value = await runLuaScript(originalAdjacencyMatrix);
});
</script>

<style>
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
