# frozen_string_literal: true

require 'forwardable'
require 'aca_entities/configuration/encryption/config'

module AcaEntities
  module Configuration
    # Module to encrypt sensitive data
    module Encryption
      class << self
        extend Forwardable

        def_delegators :config,
                       :secret_key,
                       :iv

        def configure
          yield(config)
          initialize!
        end

        def initialize!
        end

        def config
          @config ||= AcaEntities::Configuration::Encryption::Config.new
        end
      end
    end
  end
end