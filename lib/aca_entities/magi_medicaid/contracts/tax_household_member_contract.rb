# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for TaxHouseholdMember
      class TaxHouseholdMemberContract < Dry::Validation::Contract

        params do
          optional(:product_eligibility_determination).maybe(:hash)
          optional(:applicant_reference).maybe(:string)
        end

        rule(:product_eligibility_determination) do
          if key? && value
            if value.is_a?(Hash)
              result = ProductEligibilityDeterminationContract.new.call(value)
              key.failure(text: "invalid product eligibility determination", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid product eligibility determination. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
