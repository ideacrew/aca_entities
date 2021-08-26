# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) VerificationRequest
        class InsurancePolicy < Dry::Struct
          attribute :InsurancePolicyEffectiveDate, Types::Date.meta(omittable: false)
          attribute :InsurancePolicyExpirationDate, Types::Date.meta(omittable: false)
        end
      end
    end
  end
end