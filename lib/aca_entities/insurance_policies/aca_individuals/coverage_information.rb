#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      # Entity for {AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::CoverageInformationContract} with attributes
      class CoverageInformation < Dry::Struct
        attribute :tax_credit, AcaEntities::Currency.optional.meta(omittable: true)
        attribute :total_premium, AcaEntities::Currency.optional.meta(omittable: true)
        attribute :slcsp_benchmark_premium, AcaEntities::Currency.optional.meta(omittable: true)

        def <=>(other)
          [tax_credit, total_premium, slcsp_benchmark_premium] <=> [other.tax_credit, other.total_premium, other.slcsp_benchmark_premium]
        end
      end
    end
  end
end
