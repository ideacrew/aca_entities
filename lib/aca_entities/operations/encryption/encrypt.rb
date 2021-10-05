# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'rbnacl'
require 'base64'

module AcaEntities
  module Operations
    module Encryption
      # Encrypt sensitive data
      class Encrypt
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        # @param [hash] pass in value to be encrypted
        def call(params)
          encrypted_value = yield encrypt(params[:value])

          Success(encrypted_value)
        end

        private

        def encrypt(value)
          key = AcaEntities::Configuration::Encryption.config.secret_key
          iv = AcaEntities::Configuration::Encryption.config.iv
          secret_box = RbNaCl::SecretBox.new([key].pack("H*"))
          Success(Base64.encode64(secret_box.encrypt(iv, value)))
        end
      end
    end
  end
end
