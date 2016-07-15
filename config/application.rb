require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Cablush
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:'pt-BR', :en]
    config.i18n.default_locale = :'pt-BR'

    config.autoload_paths += Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each {|l| require l }

    config.active_job.queue_adapter = :sidekiq

    config.paperclip = config_for :paperclip

    # 3.3 Error handling in transaction callbacks
    config.active_record.raise_in_transactional_callbacks = true

    # Tell Rails to use our routes for error handling
    config.exceptions_app = self.routes

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: :true,
                       view_specs: :false,
                       helper_specs: :true,
                       routing_specs: :true,
                       controller_specs: :true,
                       request_specs: :true
      g.fixture_replacement :factory_girl,
                            dir: 'spec/factories'
    end
  end
end
