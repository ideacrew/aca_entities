# frozen_string_literal: true

module AcaEntities
  module Configuration
    module Encryption
      # load symmetric encryption configuration
      class Config
        attr_accessor :app_env, :encrypted_key, :encrypted_iv, :private_rsa_key

        def load_encryption
          file_path = File.join(File.dirname(__FILE__), 'symmetric-encryption.yml')
          ::SymmetricEncryption.load!(file_path, @app_env)
        end
      end
    end
  end
end