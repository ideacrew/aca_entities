#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      # Entity for {AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::CoveredIndividualContract} with attributes
      class CoveredIndividual < Dry::Struct
        attribute :coverage_start_on, Types::Date.meta(omittable: false)
        attribute :coverage_end_on, Types::Date.meta(omittable: false)
        attribute :person,          AcaEntities::People::Person.optional.meta(omittable: false)
        attribute :filer_status, Types::String.optional.meta(omittable: true)
        attribute :relation_with_primary, Types::String.optional.meta(omittable: true)

        def <=>(other)
          [coverage_start_on, coverage_end_on, person.hbx_id] <=> [other.coverage_start_on, other.coverage_end_on, other.person.hbx_id]
        end
      end
    end
  end
end
