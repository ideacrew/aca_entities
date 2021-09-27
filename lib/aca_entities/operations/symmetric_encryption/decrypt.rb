# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'symmetric_encryption'

module AcaEntities
  module Operations
    module SymmetricEncryption
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

        def encrypt(value)
          Success(::SymmetricEncryption.decrypt(value))
        end
      end
    end
  end
end
