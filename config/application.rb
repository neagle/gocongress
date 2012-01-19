require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Gocongress
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.

    # action_mailer's default_url_options should not be confused with
    # ActionController#default_url_options().  Unlike in ActionController, we
    # can only set static values here, and we can only use what's available
    # during initialization.  Specifically, this means that we cannot specify
    # a deafult year, as we do in ActionController.  -Jared 2012-01-18
    config.action_mailer.default_url_options = { :host => "www.gocongress.org" }
    
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # We don't want Heroku to try to initialize our models during assets:precompile
    # because on Heroku Cedar, the database is not available during slug compilation.
    # http://stackoverflow.com/questions/8622297/heroku-cedar-assetsprecompile-has-beef-with-attr-protected
    # http://guides.rubyonrails.org/asset_pipeline.html
    config.assets.initialize_on_precompile = false
  end
end
