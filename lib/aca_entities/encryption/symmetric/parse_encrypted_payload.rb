# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Encryption
    module Symmetric
      # Parse the header and body for an encrypted payload.
      #
      # We might return an error in the case of an invalid payload, or we
      # we might return an empty payload, as the current data was provided
      # in the 'legacy' encryption format.
      class ParseEncryptedPayload
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        def call(payload)
          return Success(LegacyEncryptedPayload.new(payload)) if payload.blank?
          return Success(LegacyEncryptedPayload.new(payload)) unless payload.include?(".")

          payload_parts = yield split_parts(payload)
          parse_header_values(payload_parts)
        end

        def split_parts(payload)
          split_attempt = Try do
            payload_parts = payload.split(".").map(&:strip)
            raise InvalidPayloadHeaderError, "Payload only had #{payload_parts.length} parts, expected 4." if payload_parts.length < 4
            payload_parts
          end

          split_attempt.to_result
        end

        def parse_header_values(payload_parts)
          parse_attempt = Try do
            algo_version = payload_parts.first
            key_version = payload_parts[1]
            nonce = Base64.decode64(payload_parts[2])
            content = Base64.decode64(payload_parts[3])
            EncryptedPayload.new(algo_version, key_version, nonce, content)
          end

          parse_attempt.to_result
        end
      end
    end
  end
end