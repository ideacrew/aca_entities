#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      class CoverageInformation < Dry::Struct
        attribute :tax_credit, AcaEntities::Currency.optional.meta(omittable: true)
        attribute :total_premium, AcaEntities::Currency.optional.meta(omittable: true)
        attribute :slcsp_benchmark_premium, AcaEntities::Currency.optional.meta(omittable: true)
      end
    end
  end
end