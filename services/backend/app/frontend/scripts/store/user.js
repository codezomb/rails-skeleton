import { defineStore } from 'pinia'
import axios from 'axios'

export default defineStore('user', {
  actions: {
    async login(email, password) {
      try {
        const resp = await axios.post('/api/users/sign_in', { user: { email, password } })
        if (resp.status === 201) this.$patch(resp.data)
      } catch (error) {
        return error
      }
    },

    async logout() {
      try {
        const resp = await axios.delete('/api/users/sign_out')
        if (resp.status === 204) this.$reset()
      } catch (error) {
        return error
      }
    }
  },

  state() {
    return {
      email: null,
      id:    null
    }
  }
})
