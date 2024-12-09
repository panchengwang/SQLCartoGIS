<template>
  <q-toolbar>
    <q-btn round flat dense>
      <q-avatar color="red" size="lg" text-color="white">
        <img src="~assets/pcwang.png" />
      </q-avatar>
    </q-btn>

    <q-toolbar-title>
      <q-btn size="md" flat dense no-caps :label="getUserName"></q-btn>
    </q-toolbar-title>

    <q-btn round flat icon="o_settings" dense size="md" />
  </q-toolbar>
</template>

<script setup>
import { computed } from "vue";
import { storeToRefs } from "pinia";
import { useApplicationStore } from "src/stores/application-store.js";

const { username, token } = storeToRefs(useApplicationStore());

const getUserName = computed(() => {
  return token.value === "" ? "Sign In" : username.value;
});

// const getCurrentTime = computed(() => {
//   return new Date().toISOString();
//   //.split("T")[0];
// });
</script>
