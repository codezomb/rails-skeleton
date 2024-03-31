/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./app/frontend/**/*.{vue,js,ts,jsx,tsx}"
  ],

  plugins: [
    require('@tailwindcss/forms')
  ],

  theme: {
    extend: {}
  }
}
