<script setup lang="js">
import { ref } from 'vue'
import EssentialLink from 'components/EssentialLink.vue'

const linksList = ref([
  {
    title: 'Parcours en largeur',
    icon: 'code',
    link: '/'
  },
  {
    title: 'Parcours en profondeur',
    icon: 'code',
    link: '/parcours-en-profondeur'
  },
  {
    title: 'Plus court chemin',
    icon: 'code',
    link: '/plus-court-chemin'
  },
  {
    title: 'Connexité',
    icon: 'code',
    link: '/connexite'
  },
  {
    title: 'Forte connexité',
    icon: 'code',
    link: '/forte-connexite'
  },
  {
    title: 'Fermeture transitive',
    icon: 'code',
    link: '/fermeture-transitive'
  }
])

const algosList = ref([
{
    title: 'Ford (Max)',
    icon: 'code',
    link: '/ford-max'
  },
  {
    title: 'Ford (Min)',
    icon: 'code',
    link: '/ford-min'
  },
  {
    title: 'Bellmann',
    icon: 'code',
    link: '/bellmann'
  },
  {
    title: 'Dijkstra',
    icon: 'code',
    link: '/dijkstra'
  },
  {
    title: 'Kruskal',
    icon: 'code',
    link: '/kruskal'
  },
  {
    title: 'Sollin',
    icon: 'code',
    link: '/sollin'
  },
  {
    title: 'Prim',
    icon: 'code',
    link: '/prim'
  },
])

const leftDrawerOpen = ref(false)

function toggleLeftDrawer () {
  leftDrawerOpen.value = !leftDrawerOpen.value
}
</script>

<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title>
          Recherche Opérationnelle
        </q-toolbar-title>

        <div>LEGENDRE Marine - FOSSIER Lucie</div>
      </q-toolbar>
      <div class="q-px-lg q-pt-xl q-mb-md">
        <div class="text-h3">Graphes</div>
      </div>
      <q-img 
      src="../assets/background.jpg"
      class="header-image absolute-top"/>
    </q-header>

    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      bordered
    >
      <q-list>
        <q-item-label
          header
        >
          Généralités
        </q-item-label>

        <EssentialLink
          v-for="link in linksList"
          :key="link.title"
          v-bind="link"
        />        

        <q-item-label
          header
        >
          Algorithmes
        </q-item-label>

        <EssentialLink
          v-for="algo in algosList"
          :key="algo.title"
          v-bind="algo"
        />        
      </q-list>
    </q-drawer>

    <q-page-container>
        <router-view />
    </q-page-container>
  </q-layout>
</template>


<style lang="scss">
.header-image {
  height: 100%;
  z-index: -1;
  opacity: 0.2;
  filter: grayscale(100%);
}
</style>
