# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for Fdsh ESI(employer sponsored insurance) VerificationResponse
        class MonthlyPremiumAmountContract < Dry::Validation::Contract
          params do
            required(:EmployeePremiumAmount).filled(AcaEntities::Fdsh::Esi::H14::Contracts::InsurancePremiumContract.params)
            required(:FamilyPremiumAmount).filled(AcaEntities::Fdsh::Esi::H14::Contracts::InsurancePremiumContract.params)
          end
        end
      end
    end
  end
end