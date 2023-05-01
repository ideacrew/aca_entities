#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      # Entity for {AcaEntities::InsurancePolicies::MonthOfYearContract} with attributes
      class MonthOfYear < Dry::Struct
        attribute :month, Types::String.meta(omittable: false)
        attribute :coverage_information, AcaEntities::InsurancePolicies::AcaIndividuals::CoverageInformation.optional.meta(omittable: true)

        def <=>(other)
          [month, coverage_information] <=> [other.month, other.coverage_information]
        end
      end
    end
  end
end