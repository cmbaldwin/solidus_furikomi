# frozen_string_literal: true

module SolidusFurikomi
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'solidus_furikomi'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    initializer 'spree.register.payment_methods' do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::Furikomi
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
