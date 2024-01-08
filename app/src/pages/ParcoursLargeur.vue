<script setup lang="js">
import axios from 'axios';
import { ref, onMounted } from 'vue';
import data from "../tree/graph_oriente"
import dagre from "dagre/dist/dagre.min.js"
import * as vNG from "v-network-graph"

const runLuaScript = async () => {
  try {
    // Effectuer une requête POST pour exécuter le script Lua
    const response = await axios.post('http://localhost:3000/', {
      script: 'parcours_largeur', // nom exact du script
      data: { makey: 'mavaleur', makey2: 'maval2' },
    });
    return response.data.result.split('\r\n')
  } catch (error) {
    console.error('Error calling the Lua script:', error);
  }
};

const res = ref('')
onMounted(async () => {
  res.value = await runLuaScript();
});

const nodeSize = 40

const configs = vNG.defineConfigs({
  view: {
    scalingObjects: true,
    autoPanAndZoomOnLoad: "fit-content",
    onBeforeInitialDisplay: () => layout("LR"),
  },
  node: {
    normal: { radius: nodeSize / 2 },
    label: { direction: "center", color: "#fff" },
  },
  edge: {
    normal: {
      color: "#aaa",
      width: 3,
    },
    margin: 4,
    marker: {
      target: {
        type: "arrow",
        width: 4,
        height: 4,
      },
    },
  },
})

// place les noeuds automatiquement sans chevauchement
function layout(direction) {
  if (Object.keys(data.nodes).length <= 1 || Object.keys(data.edges).length == 0) {
    return
  }

  // convert graph
  // ref: https://github.com/dagrejs/dagre/wiki
  const g = new dagre.graphlib.Graph()
  // Set an object for the graph label
  g.setGraph({
    rankdir: direction,
    nodesep: nodeSize * 2,
    edgesep: nodeSize,
    ranksep: nodeSize * 2,
  })
  // Default to assigning a new object as a label for each new edge.
  g.setDefaultEdgeLabel(() => ({}))

  // Add nodes to the graph. The first argument is the node id. The second is
  // metadata about the node. In this case we're going to add labels to each of
  // our nodes.
  Object.entries(data.nodes).forEach(([nodeId, node]) => {
    g.setNode(nodeId, { label: node.name, width: nodeSize, height: nodeSize })
  })

  // Add edges to the graph.
  Object.values(data.edges).forEach(edge => {
    g.setEdge(edge.source, edge.target)
  })

  dagre.layout(g)

  g.nodes().forEach((nodeId) => {
    // update node position
    const x = g.node(nodeId).x
    const y = g.node(nodeId).y
    data.layouts.nodes[nodeId] = { x, y }
  })
}
</script>

<template>
  <q-page class="q-pa-lg">
    <h5 class="q-mt-none">Parcours en largeur </h5>
    <div class="graphContainer">
      <v-network-graph 
        class="graph"
        :nodes="data.nodes" 
        :edges="data.edges" 
        :layouts="data.layouts" 
        :configs="configs" 
      />
    </div>
    <p>{{ res[0] }}</p>
    <p>{{ res[1] }}</p>
  </q-page>
</template>

<style>
.graphContainer {
  height: 250px;
}
.graph {
  height: 100%;
}
</style>