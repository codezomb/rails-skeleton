import { createWebHistory, createRouter } from 'vue-router'
import authentication from './authentication.js'

const routes = [
  ...authentication
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
