# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      # entity for NonEsiMecIndividualInformation
      class NonEsiMecIndividualInformation < Dry::Struct
        attribute :person_ssn, Types::String.meta(omittable: false)
        attribute :person_name, PersonName.meta(omittable: false)
        attribute :person_date_of_birth, Types::Date.meta(omittable: false)
        #switch to type once built
        attribute :person_sex_code, Types::String.optional.meta(omittable: true)
        attribute :requested_insurance_period, RequestedInsurancePeriod.meta(omittable: false)
        # switch to type once built
        attribute :organization_code, Types::String.meta(omittable: false)
      end
    end
  end
end