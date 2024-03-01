# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Encryption
    module Symmetric
      # Encrypte a payload.
      class EncryptPayload
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        def call(payload)
          encrypted = yield construct_encrypted_payload(payload)
          encode_payload(encrypted)
        end

        def construct_encrypted_payload(payload)
          encryption_attempt = Try do
            current_algo_v = KeyManager.current_algo_version
            current_key_v = KeyManager.current_key_version
            key = KeyManager.resolve_key(current_algo_v, current_key_v)
            encrypt_box = RbNaCl::SecretBox.new(key)
            nonce = Nonce.generate(encrypt_box.nonce_bytes)
            content = encrypt_box.encrypt(nonce, payload)
            EncryptedPayload.new(
              current_algo_v,
              current_key_v,
              nonce,
              content
            )
          end
          encryption_attempt.to_result
        end

        def encode_payload(encrypted)
          encoded_result = Try do
            # rubocop:disable Style/StringConcatenation
            encrypted.algo_version + "." + encrypted.key_version + "." +
              Base64.strict_encode64(encrypted.nonce) + "." +
              Base64.strict_encode64(encrypted.content)
            # rubocop:enable Style/StringConcatenation
          end

          encoded_result.to_result
        end
      end
    end
  end
end