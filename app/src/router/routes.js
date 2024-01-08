
const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', component: () => import('pages/ParcoursLargeur.vue') },
      { path: '/parcours-en-profondeur', component: () => import('pages/ParcoursProfondeur.vue') },
      { path: '/plus-court-chemin', component: () => import('pages/PlusCourtChemin.vue') },
      { path: '/connexite', component: () => import('pages/SimpleConnexite.vue') },
      { path: '/forte-connexite', component: () => import('pages/ForteConnexite.vue') },
      { path: '/fermeture-transitive', component: () => import('pages/FermetureTransitive.vue') },
      { path: '/ford-max', component: () => import('pages/FordMax.vue') },
      { path: '/ford-min', component: () => import('pages/FordMin.vue') },
      { path: '/bellmann', component: () => import('pages/AlgoBellmann.vue') },
      { path: '/dijkstra', component: () => import('pages/AlgoDijkstra.vue') },
      { path: '/kruskal', component: () => import('pages/AlgoKruskal.vue') },
      { path: '/sollin', component: () => import('pages/AlgoSollin.vue') },
      { path: '/prim', component: () => import('pages/AlgoPrim.vue') }
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  }
]

export default routes
