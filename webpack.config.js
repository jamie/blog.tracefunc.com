const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const MyMiniCssExtractPlugin = new MiniCssExtractPlugin({
  filename: 'assets/[name].css',
  chunkFilename: '[id].css'
});

const JSLoader = {
  test: /\.js$/,
  exclude: /node_modules/,
  use: {
    loader: 'babel-loader',
    options: { presets: ['@babel/preset-env'] }
  }
};

const ESLintLoader = {
  test: /\.js$/,
  enforce: 'pre',
  exclude: /node_modules/,
  use: {
    loader: 'eslint-loader',
    options: { configFile: '.eslintrc' },
  }
};

const CSSLoader = {
  test: /\.(sa|sc|c)ss$/,
  exclude: /node_modules/,
  use: [
    // { loader: MiniCssExtractPlugin.loader,
    //   options: {
    //     publicPath: path.resolve(__dirname, 'assets/'),
    //     sourceMap: true
    //   }
    // },
    { loader: 'css-loader', options: { sourceMap: true } },
    { loader: 'postcss-loader',
      options: {
        sourceMap: true,
        config: { path: path.resolve(__dirname, 'postcss.config.js') }
      }
    },
    { loader: 'sass-loader', options: { sourceMap: true } }
  ],
};

module.exports = {
  entry: {
    application: './source/assets/site.js',
    styles: './source/assets/site.css',
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '.tmp/dist'),
  },
  module: {
    rules: [ JSLoader, ESLintLoader, CSSLoader ]
  },
  plugins: [ MyMiniCssExtractPlugin ],
}
