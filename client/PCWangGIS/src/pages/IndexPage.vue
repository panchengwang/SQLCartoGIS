<template>
  <q-page class="row fit flex no-wrap justify-between">
    <div class="bg-indigo-1" style="width: 150px">
      <account-panel style="padding: 5px"></account-panel>
    </div>
    <div class="col column">
      <div class="bg-indigo-1" style="min-height: 24px; max-height: 24px"></div>
      <div class="col bg-green-2"></div>
    </div>
  </q-page>
</template>

<script setup>
import AccountPanel from "../components/AccountPanel.vue";
</script>
