# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a NonEsiMecIndividualInformation.
          class GetEligibilityIndividualInformation
            include HappyMapper
            register_namespace 'v1', 'http://xmlns.dhcf.dc.gov/dcas/Medicaid/Eligibility/xsd/v1'

            tag 'GetEligibilityRequest'
            namespace 'v1'

            element :person_ssn, String, tag: "SSN", namespace: "v1"

            # person name
            has_one :person_name, PersonName

            element :person_date_of_birth, Date, tag: "DOB", namespace: "v1"

            # optional value
            element :person_sex_code, String, tag: "Gender", namespace: "v1"

            def self.domain_to_mapper(info)
              mapper = self.new
              mapper.person_ssn = info[:person_ssn]
              mapper.person_name = V1::PersonName.domain_to_mapper(info[:person_name])
              mapper.person_date_of_birth = info[:person_date_of_birth]
              mapper.person_sex_code = info[:person_sex_code]
              mapper
            end

            def to_hash
              {
                person_ssn: person_ssn,
                person_name: person_name.to_hash,
                person_date_of_birth: person_date_of_birth,
                person_sex_code: person_sex_code
              }
            end
          end
        end
      end
    end
  end
end