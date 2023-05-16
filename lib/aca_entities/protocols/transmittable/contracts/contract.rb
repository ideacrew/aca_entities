# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # Transmittable module Contract class (inherits from the {AcaEntities::Contracts::Contract}) top level contract class
        class Contract < AcaEntities::Contracts::Contract
          # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

          rule(:ended_at, :started_at) do
            if keys && values[:started_at].present? && values[:ended_at].present? && values[:ended_at] < values[:started_at]
              key.failure('must be after started_at')
            end
          end

          rule(:transactions).each do |index:|
            next unless key? && value.is_a?(Hash)
            values.to_h[:transactions[index]]&.each_pair do |attr_key, attr_val|
              result = TransactionContract.new.call(attr_val)
              next unless result.failure?

              key([*path, attr_key]).failure(
                { text: 'error', code: result.errors.to_h }
              )
            end
          end

          rule(:transmissions).each do |index:|
            next unless key? && value.is_a?(Hash)
            values.to_h[:transmissions[index]]&.each_pair do |attr_key, attr_val|
              result = TransmissionContract.new.call(attr_val)
              next unless result.failure?

              key([*path, attr_key]).failure(
                { text: 'error', code: result.errors.to_h }
              )
            end
          end

        end
      end
    end
  end
end