import { defineStore, acceptHMRUpdate } from "pinia";

export const useApplicationStore = defineStore("application-store", {
  state: () => ({
    version: "0.0.1",
    username: "laowang",
    token: "asfsdfsf"
  }),

  getters: {
    hasSignIn: (state) => {
      return state.token.trim() !== ''
    }
  },

  actions: {},
});

// export default useApplicationConfiguration;

if (import.meta.hot) {
  import.meta.hot.accept(acceptHMRUpdate(useApplicationStore, import.meta.hot));
}
