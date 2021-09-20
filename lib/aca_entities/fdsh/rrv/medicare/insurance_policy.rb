# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Entity for InsurancePolicy
        class InsurancePolicy < Dry::Struct
          attribute :InsurancePolicyEffectiveDate, Types::Date.meta(omittable: false)
          attribute :InsurancePolicyExpirationDate, Types::Date.meta(omittable: false)
        end
      end
    end
  end
end