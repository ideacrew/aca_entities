#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      class MonthOfYear < Dry::Struct
        attribute :month, Types::String.meta(omittable: false)
        attribute :coverage_information, AcaEntities::InsurancePolicies::AcaIndividuals::CoverageInformation.optional.meta(omittable: true)
      end
    end
  end
end