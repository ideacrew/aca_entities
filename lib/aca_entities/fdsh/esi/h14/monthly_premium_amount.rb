# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationResponse
        class MonthlyPremiumAmount < Dry::Struct
          attribute :EmployeePremiumAmount, Fdsh::Esi::H14::InsurancePremium.meta(omittable: true)
          attribute :FamilyPremiumAmount, Fdsh::Esi::H14::InsurancePremium.meta(omittable: true)
        end
      end
    end
  end
end