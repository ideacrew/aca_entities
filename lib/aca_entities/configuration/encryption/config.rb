# frozen_string_literal: true

module AcaEntities
  module Configuration
    module Encryption
      # load symmetric encryption configuration
      class Config
        attr_accessor :app_env, :encrypted_key, :encrypted_iv, :key, :iv, :private_rsa_key

        def load_encryption
        end
      end
    end
  end
end