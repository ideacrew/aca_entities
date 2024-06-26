# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Encryption
    module Symmetric
      # Decrypt a payload.
      class DecryptPayload
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        def call(payload)
          encrypted_payload = yield parse_header_and_payload(payload)
          decrypt_payload(encrypted_payload)
        end

        def parse_header_and_payload(payload)
          ParseEncryptedPayload.new.call(payload)
        end

        def decrypt_payload(encrypted_payload)
          if encrypted_payload.header?
            found_key = yield lookup_key(encrypted_payload)
            decryption_result = Try do
              decryption_box = RbNaCl::SecretBox.new(found_key)
              decryption_box.decrypt(encrypted_payload.nonce, encrypted_payload.content)
            end
            decryption_result.to_result
          else
            secret_box = RbNaCl::SecretBox.new(LegacyKeyset.secret_key)
            Success(secret_box.decrypt(LegacyKeyset.iv, Base64.decode64(encrypted_payload.content)))
          end
        end

        def lookup_key(encrypted_payload)
          key_result = Try do
            KeyManager.resolve_key(encrypted_payload.algo_version, encrypted_payload.key_version)
          end

          key_result.to_result
        end
      end
    end
  end
end