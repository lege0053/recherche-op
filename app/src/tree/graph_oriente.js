import { reactive } from "vue"

const nodes = {
    A: { name: "A" },
    B: { name: "B" },
    C: { name: "C" },
    D: { name: "D" },
    E: { name: "E" },
    F: { name: "F" },
}
  
const edges = {
    edge1: { source: "A", target: "B" },
    edge2: { source: "A", target: "C" },
    edge3: { source: "C", target: "B" },
    edge4: { source: "C", target: "E" },
    edge5: { source: "D", target: "C" },
    edge6: { source: "E", target: "D" },
    edge7: { source: "E", target: "F" },
    edge8: { source: "F", target: "B" },
}

const layouts = reactive({
    nodes: {},
  })


export default {
  nodes,
  edges,
  layouts,
}