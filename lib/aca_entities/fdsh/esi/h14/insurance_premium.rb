# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationResponse
        class InsurancePremium < Dry::Struct
          attribute :InsurancePremiumAmount, Types::Decimal.meta(omittable: false)
        end
      end
    end
  end
end