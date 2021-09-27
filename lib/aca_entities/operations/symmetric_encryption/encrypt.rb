# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'symmetric_encryption'

module AcaEntities
  module Operations
    module SymmetricEncryption
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
          Success(::SymmetricEncryption.encrypt(value))
        end
      end
    end
  end
end
