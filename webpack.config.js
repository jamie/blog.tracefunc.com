const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  plugins: [
    new MiniCssExtractPlugin()
  ],
  entry: {
    application: './source/assets/site.js',
    styles: './source/assets/site.css',
  },
  output: {
    path: __dirname + '/.tmp/dist',
    filename: '[name].js',
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        exclude: /node_modules/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {
              hmr: process.env.NODE_ENV === 'development',
            },
          },
          'css-loader',
          'postcss-loader',
        ]
      }
    ]
  }
}
