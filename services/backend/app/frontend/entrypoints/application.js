import Application from '@/scripts/components/index.vue'
import appRouter from '@/scripts/router/index.js'
import { createPinia } from 'pinia'
import { createApp } from 'vue'

// Initialize and setup the Vue application
createApp(Application)
  .use(createPinia())
  .use(appRouter)
  .mount('#app')
