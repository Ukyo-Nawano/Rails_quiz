const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.{html,erb,haml,slim}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/assets/stylesheets/**/*.css',
    './app/assets/stylesheets/**/*.scss',
    './app/components/**/*.{html,erb,haml,slim}',
    './app/assets/builds/**/*.css',
    './public/index.html',
  ],
  theme: {
    extend: {
      fontFamily: {
        'noto': ['Noto Sans JP', 'sans-serif'],
      },
      colors: {
        white: "#FFFFFF",
        black: "#000000",
        gray: {
            DEFAULT: "#C9CDDA",
            50: "#F5F6F8",
            100: "#ECEEF3",
            200: "#DDE0E8",
            300: "#C9CDDA",
            400: "#B1B4C8",
            500: "#9C9EB8",
            600: "#8687A5",
            700: "#737290",
            800: "#5E5E75",
            900: "#4F4F60",
            950: "#2E2E38",
        },
        green:{
            50:"#F1F8F8",
            75:"#66c7bc",
            100:"#3DB8A4",
        },
        blue:{
            50:"#9CD4FC",
            75:"#54ACEC",
            100:"#1E4679",
        },
        red:{
            100:"#FF7F7F",
        },
        yellow:{
            100:"#F7B32B",
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
