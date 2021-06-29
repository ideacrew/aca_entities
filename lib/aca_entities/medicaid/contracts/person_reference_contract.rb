# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonReference.
      class PersonReferenceContract < Dry::Validation::Contract

        params do
          optional(:ref).maybe(:string)
        end
      end
    end
  end
end
