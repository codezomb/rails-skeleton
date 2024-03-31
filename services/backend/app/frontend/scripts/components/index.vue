<template>
  <application v-if="authenticated" />
  <router-view v-else />
</template>

<script>
import userStore from '@/scripts/store/user'
import Application from './application.vue'

export default {
  components: { Application },
  computed: {
    authenticated() {
      return this.store.id !== null
    }
  },

  created() {
    this.store = userStore()
    if (this.authenticated)
      return

    this.$router.push({
      name: 'login'
    })
  }
}
</script>
