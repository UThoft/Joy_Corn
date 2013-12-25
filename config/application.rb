require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module JoyCorn
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    #config.time_zone = 'Melbourne'
    # If you set config.assets.initialize_on_precompile to false,
    # be sure to test rake assets:precompile locally before deploying.
    # It may expose bugs where your assets reference application objects or methods,
    # since those are still in scope in development mode regardless of the value of this flag.
    # Changing this flag also affects engines. Engines can define assets for precompilation as well.
    # Since the complete environment is not loaded, engines (or other gems) will not be loaded,
    # which can cause missing assets.

    config.assets.initialize_on_precompile = false

    config.app_generators.stylesheet_engine = :sass

    #config.serve_static_assets = true

  end
end
