# frozen_string_literal: true

require 'dry/validation'

Dry::Validation.load_extensions(:monads)

# Configuration values and shared rules and macros for domain model validation contracts
module AcaEntities
  module Protocols
    module Transmitable
      module Contracts
        # Transmittable module Contract class (inherits from the {AcaEntities::Contracts::Contract}) top level contract class
        class Contract < AcaEntities::Contracts::Contract
          # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

          rule(:ended_at, :started_at) do
            if [values[:ended_at], values[:started_at]].none?(&:nil?) && values[:ended_at] < values[:started_at]
              key.failure('must be after started_at')
            end
          end

        end
      end
    end
  end
end