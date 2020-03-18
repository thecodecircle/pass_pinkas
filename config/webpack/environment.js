const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

var config = Encore.getWebpackConfig();

config.module.rules.unshift({
  parser: {
    amd: false,
  }
});

module.exports = environment
