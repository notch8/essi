require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require File.expand_path('../../config/initializers/_essi_config.rb', __FILE__)

module ESSI
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += ['app/models/vocab', Rails.root.join('lib')]
    config.eager_load_paths += ['app/models/vocab', Rails.root.join('lib')]

    config.to_prepare do
      Dir.glob(File.join(File.dirname(__FILE__), '../lib/extensions/flexible_metadata_extensions.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
