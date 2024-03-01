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
          AcaEntities::Encryption::Symmetric.encrypt(params[:value])
        end
      end
    end
  end
end
