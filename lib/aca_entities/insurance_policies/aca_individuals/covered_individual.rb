#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      class CoveredIndividual < Dry::Struct
        attribute :coverage_start_on, Types::Date.meta(omittable: false)
        attribute :coverage_end_on, Types::Date.meta(omittable: false)
        attribute :person,          AcaEntities::People::Person.optional.meta(omittable: false)
        attribute :filer_status, Types::String.optional.meta(omittable: true)
        attribute :relation_with_primary, Types::String.optional.meta(omittable: true) end
    end
  end
end