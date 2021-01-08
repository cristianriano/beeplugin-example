const { environment } = require('@rails/webpacker')
const webpack = require("webpack");

// Avoid using require and import and alias jquery
environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
  })
);

module.exports = environment
