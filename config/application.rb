require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Microposts
  class Application < Rails::Application
# 以下を無効にしないとcustom.scssを基にcssファイルが自動生成されレイアウトが崩れる
#    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework false
    end
  end
end
