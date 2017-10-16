# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end
Obscenity.configure do |config|
  config.blacklist   = File.dirname(__FILE__) + "/../blacklist.yml"
  config.whitelist   = ["safe", "word"]
  config.replacement = :stars
end
