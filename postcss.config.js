const purgecss = require('@fullhuman/postcss-purgecss')

class TailwindExtractor {
  static extract(content) {
    return content.match(/[A-z0-9-:\/]+/g) || []
  }
}

module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss'),
    require('autoprefixer'),
    // purgecss({
    //   content: [
    //     __dirname + '/source/**/*.html',
    //     __dirname + '/source/**/*.erb'
    //   ],
    //   extractors: [{
    //     extractor: TailwindExtractor,
    //     extensions: ['html', 'erb', 'html.erb']
    //   }],
    //   css: ['.tmp/dist/*.css'],
    // }),
  ]
}
