# frozen_string_literal: true

require "base64"
require_relative "symmetric/legacy_keyset"
require_relative "symmetric/key_manager"
require_relative "symmetric/encrypted_payload"
require_relative "symmetric/legacy_encrypted_payload"
require_relative "symmetric/parse_encrypted_payload"
require_relative "symmetric/decrypt_payload"
require_relative "symmetric/encrypt_payload"

module AcaEntities
  module Encryption
    # Management and algorithms for symmetric algorithms, supported by
    # libsodium.
    module Symmetric
      # Algorithm implementation versions.
      #
      # Right now we have only Version 1.
      ALGO_VERSIONS = ["S1"].freeze
      CURRENT_ALGO_VERSION = "S1"

      class InvalidPayloadHeaderError < StandardError; end

      class KeyNotFoundError < StandardError; end

      # Manages nonces for symmetric encryption
      class Nonce
        def self.generate(byte_size)
          RbNaCl::Random.random_bytes(byte_size)
        end
      end

      def decrypt(payload)
        DecryptPayload.new.call(payload)
      end

      def encrypt(payload)
        EncryptPayload.new.call(payload)
      end

      module_function :decrypt, :encrypt
    end
  end
end