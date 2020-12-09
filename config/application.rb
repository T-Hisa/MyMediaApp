require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # I18n.available_locales = [:ja, :en]
    config.i18n.fallbacks = [I18n.default_locale]
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.yml').to_s]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # rails generate コマンド時の挙動
    # config.generators do |g|
    #   g.test_framework :rspec, 
    #     view_specs: false, 
    #     helper_specs: false, 
    #     controller_specs: false, 
    #     routing_specs: false

    #   # Railsジェネレータがfactory_bot用のファイルを生成するのを無効化
    #   g.factory_bot false

    #   # ファクトリファイルの置き場を変更
    #   g.factory_bot dir: 'custom/dir/for/factories'
    # end
  end
end
