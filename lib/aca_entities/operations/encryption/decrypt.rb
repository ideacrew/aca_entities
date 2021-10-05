# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'rbnacl'
require 'base64'

module AcaEntities
  module Operations
    module Encryption
      # Encrypt sensitive data
      class Decrypt
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        # @param [hash] pass in value to be encrypted
        def call(params)
          decrypted_value = yield decrypt(params[:value])

          Success(decrypted_value)
        end

        private

        def decrypt(value)
          key = AcaEntities::Configuration::Encryption.config.simple_box_secret_key
          secret_box = RbNaCl::SimpleBox.from_secret_key([key].pack("H*"))
          Success(secret_box.decrypt(Base64.decode64(value)))
        end
      end
    end
  end
end
