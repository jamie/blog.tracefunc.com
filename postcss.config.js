const inProduction = (process.env.NODE_ENV == 'production');

class TailwindExtractor {
  static extract(content) {
    return content.match(/[A-z0-9-:\/]+/g) || []
  }
}

const DEV_PLUGINS = [
  require('postcss-import')(),
  require('tailwindcss')(),
  require('autoprefixer')()
]
const PROD_PLUGINS = [
  require('postcss-import')(),
  require('tailwindcss')(),
  require('autoprefixer')(),
  require('cssnano')()
]

module.exports = {
  plugins: inProduction ? PROD_PLUGINS : DEV_PLUGINS
}