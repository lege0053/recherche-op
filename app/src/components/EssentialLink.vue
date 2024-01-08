<script setup lang="js">

const props = defineProps({
  title: {
    type: String,
    required: true
  },
  link: {
    type: String,
    default: '/'
  },
  icon: {
    type: String,
    default: ''
  }
  }
)
</script>

<template>
  <q-item
    :to="link"
    exact
    clickable
    v-ripple
  >
    <q-item-section
      v-if="icon"
      avatar
    >
      <q-icon :name="icon" />
    </q-item-section>

    <q-item-section>
      <q-item-label>{{ title }}</q-item-label>
    </q-item-section>
  </q-item>
</template>

