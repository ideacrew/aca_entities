# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for NonMagiEligibilityBasis
      class NonMagiEligibilityBasisContract < Dry::Validation::Contract

        params do
          optional(:person_disabled).maybe(:bool)
          optional(:person_disable_status_code).maybe(:string)
          optional(:medicare_entitlement).maybe(:bool)
          optional(:medicare_entitlement_status_code).maybe(:string)
        end
      end
    end
  end
end
