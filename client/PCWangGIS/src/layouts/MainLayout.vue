<template>
  <q-layout view="lHh Lpr lFf" class="bg-indigo-1">
    <q-header>
      <account-panel></account-panel>
    </q-header>

    <q-page-container class="fit">
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
// import { computed } from "vue";
// import { storeToRefs } from "pinia";
// import { useApplicationStore } from "src/stores/application-store.js";

// const { version, username, hasSignIn } = storeToRefs(useApplicationStore());

// const getUserName = computed(() => {
//   return hasSignIn ? "Sign In" : username.value;
// });
</script>

<style scoped>
.q-toolbar {
  min-height: 32px;
}
</style>
