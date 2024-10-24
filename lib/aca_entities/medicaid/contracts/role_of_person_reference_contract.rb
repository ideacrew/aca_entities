# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for RoleOfPersonReference.
      class RoleOfPersonReferenceContract < Dry::Validation::Contract

        params do
          required(:ref).filled(:string)
        end
      end
    end
  end
end
