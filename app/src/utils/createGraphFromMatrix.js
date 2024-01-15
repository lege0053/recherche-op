import { reactive } from "vue";
import * as vNG from "v-network-graph"; // dessin et config du graph
import dagre from "dagre/dist/dagre.min.js"; // disposition auto des noeuds du graph

/**
 * Construire les nœuds et les arêtes à partir d'une matrice d'adjacence
 * @param {Array} matrix 
 * @returns nodes et edges
 */
function buildNodesAndEdgesFromMatrix(matrix, weight=false) {
  const nodes = {};
  const edges = {};

   // Parcourt des lignes de la matrice pour créer les noeuds
   for (let rowId = 0; rowId < matrix.length; rowId++) {
    // ASCII 65 = A --> on incrément le numéro ASCII pour avoir A...Z
    const sourceNode = String.fromCharCode(65 + rowId);
    nodes[sourceNode] = { name: sourceNode };

    // Parcourt des colonnes de matrice pour créer les arêtes
    for (let colId = 0; colId < matrix[rowId].length; colId++) {
      const value = matrix[rowId][colId];
      if (value) {
        const targetNode = String.fromCharCode(65 + colId);
        // Crée un nom d'arête unique
        const edgeName = `edge${Object.keys(edges).length + 1}`;
        // Ajoute l'arête à l'objet des arêtes
        edges[edgeName] = { source: sourceNode, target: targetNode, label: weight? value+'' : ''};
      }
    }
  }

  return { nodes, edges };
}

/**
 * Créer le graphe à partir de la matrice d'adjacence
 * @param {Array} adjacencyMatrix 
 * @returns 
 */
function createGraphFromMatrix(adjacencyMatrix, weight=false) {
  // récupère les noeuds et les arrêtes à partir de la matrice d'adjacence
  const { nodes, edges } = buildNodesAndEdgesFromMatrix(adjacencyMatrix, weight);
  // va stocker les positions des noeuds
  const layouts = reactive({
    nodes: {},
  });
  // définit la taille des noeuds
  const nodeSize = 40;

  // Définit les configurations du graphe avec v-network-graph
  // https://dash14.github.io/v-network-graph/reference/configurations.html
  const configs = vNG.defineConfigs({
    view: {
      scalingObjects: true,
      autoPanAndZoomOnLoad: "fit-content",
      // Appelle layout() avant l'affichage initial avec une direction spécifiée (horizontale)
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
      label: {
        fontSize: 11,
        lineHeight: 1.1,
        color: "#000000",
        margin: 4,
        background: {
          visible: true,
          color: "#ffffff",
          padding: {
            vertical: 1,
            horizontal: 4,
          },
          borderRadius: 2,
        },
      }
    },
  });

  /**
   * Effectue la disposition des nœuds
   * @param {String} direction LR pour horizontale, TB pour verticale
   * @returns 
   */
  function layout(direction) {
    // Vérifie s'il y a plus d'un nœud et au moins une arête
    if (Object.keys(nodes).length <= 1 || Object.keys(edges).length === 0) {
      return;
    }

    // Crée un objet graphique avec la bibliothèque dagre
    const g = new dagre.graphlib.Graph();
    // paramètres de disposition
    g.setGraph({
      rankdir: direction,
      nodesep: nodeSize * 2,
      edgesep: nodeSize,
      ranksep: nodeSize * 2,
    });

    // fonction par défaut pour les étiquettes des arêtes
    g.setDefaultEdgeLabel(() => ({}));

    // Ajoute les noeud au graphique avec les positions initiales
    Object.entries(nodes).forEach(([nodeId, node]) => {
      g.setNode(nodeId, { label: node.name, width: nodeSize, height: nodeSize });
    });

    // Ajoute les arêtes au graphique
    Object.values(edges).forEach((edge) => {
      g.setEdge(edge.source, edge.target);
    });

    // Effectue la disposition avec dagre
    dagre.layout(g);

    // Met à jour les positions des nœuds dans l'objet réactif
    g.nodes().forEach((nodeId) => {
      const x = g.node(nodeId).x;
      const y = g.node(nodeId).y;
      layouts.nodes[nodeId] = { x, y };
    });
  }

  return { nodes, edges, layouts, configs };
}

export { createGraphFromMatrix };
