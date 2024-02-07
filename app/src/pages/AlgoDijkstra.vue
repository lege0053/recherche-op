<script setup lang="js">
import axios from 'axios';
import { ref, onMounted } from 'vue';
import {createGraphFromMatrix } from "../utils/createGraphFromMatrix"

// fonction exécutant le script Lua via une requête HTTP
const runLuaScript = async () => {
  try {
    const response = await axios.post('http://localhost:3000/', {
      script: 'disjkstra', // Nom exact du script Lua à exécuter (/api/scripts/)
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
  [0, 5, 2, 0, 10, 0],
  [0, 0, 0, 8, 0, 3],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 8],
  [0, 0, 0, 2, 0, 0],
];
// Appelle la fonction createGraphFromMatrix pour obtenir les données du graphe
const { nodes, edges, layouts, configs } = createGraphFromMatrix(adjacencyMatrix, true);

const matrixText = adjacencyMatrix.map(row => `[${row.join(', ')}]`).join(',\n')


</script>

<template>
  <q-page class="q-pa-lg">
    <h5 class="q-mt-none">Dijkstra</h5>

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
      <div class="right">
        <p style="font-size:15pt ; font-weight: 600; color: #3355BB;" >Resultats</p>
        <p v-for="(result, index) in res" :key="index">{{ result }}</p>
      </div>

    </div>

  </q-page>
</template>

<style>
.container {
  display: flex;
}

.left {
  flex: 1;  /* Utilise l'espace disponible */
  margin-right: 20px;  /* Marge entre la partie gauche et la partie droite */
}

.graphContainer {
  height: 300px;
}

.graph {
  height: 100%;
}

.right {
  flex: 1;  /* Utilise l'espace disponible */
}
</style>
