# frozen_string_literal: true

module AcaEntities
  module Encryption
    module Symmetric
      # A standard payload with a header for encryption.
      class EncryptedPayload
        attr_reader :algo_version, :key_version, :nonce, :content

        def initialize(a_version, k_version, nonce_value, content_value)
          @algo_version = a_version
          @key_version = k_version
          @nonce = nonce_value
          @content = content_value
        end

        def header?
          true
        end
      end
    end
  end
end