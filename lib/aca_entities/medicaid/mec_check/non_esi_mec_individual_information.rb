# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      # entity for NonEsiMecIndividualInformation
      class NonEsiMecIndividualInformation < Dry::Struct
        attribute :person_ssn, Types::String.optional.meta(omittable: true)
        attribute :person_name, PersonName.meta(omittable: false)
        attribute :person_date_of_birth, Types::Date.meta(omittable: false)
        attribute :person_sex_code, Types::GenderCode.optional.meta(omittable: true)
        attribute :requested_insurance_period, RequestedInsurancePeriod.meta(omittable: false)
        attribute :organization_code, Types::OrganizationCode.meta(omittable: false)
      end
    end
  end
end