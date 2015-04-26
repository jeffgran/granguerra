require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Granguerra
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

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    SALT = "bBeslpbsZLICoBRtRyYCorPQYs0p399uiJzUj4bRbfWEKZpZ03Vg2veHWw5TuckawcS5ym3HY9hRSf3AxYkgWQ"
    CRYPTED_PASSWORD = "$2a$10$/J3xY.dxxBCPdlSgH6sSX.sdtqPgE1yPOkQV8Iwgq98Wgqwh6266i"

    # [JG] to generate a new password:
    # rails c
    # irb(main):001:0> BCrypt::Password.create("mypassword"+Granguerra::Application::SALT)
    # => "$2a$10$/J3xY.dxxBCPdlSgH6sSX.sdtqPgE1yPOkQV8Iwgq98Wgqwh6266i"
    # 
    # then copy/paste that string above to be the new CRYPTED_PASSWORD.
  end
end
