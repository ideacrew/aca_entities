# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of a NonEsiMecIndividualInformation.
          class NonEsiMecIndividualInformation
            include HappyMapper

            tag 'NonESIMECindividualInformation'
            namespace 'gov'

            element :person_ssn, String, tag: "PersonSSN", namespace: "gov"

            # person name
            has_one :person_name, PersonName

            element :person_date_of_birth, Date, tag: "PersonDateOfBirth", namespace: "gov"

            # optional value
            element :person_sex_code, String, tag: "PersonSexCode", namespace: "gov"

            has_one :requested_insurance_period, RequestedInsurancePeriod

            element :organization_code, String, tag: "OrganizationCode", namespace: "gov"

            def self.domain_to_mapper(info)
              mapper = self.new
              mapper.person_ssn = info.person_ssn
              mapper.person_name = PersonName.domain_to_mapper(info.person_name)
              mapper.person_date_of_birth = info.person_date_of_birth
              mapper.person_sex_code = info.person_sex_code
              mapper.requested_insurance_period = RequestedInsurancePeriod.domain_to_mapper(info.requested_insurance_period)
              mapper.organization_code = info.organization_code
              mapper
            end

            def to_hash()
              {
                person_ssn: person_ssn,
                person_name: person_name.to_hash,
                person_date_of_birth: person_date_of_birth,
                person_sex_code: person_sex_code,
                requested_insurance_period: requested_insurance_period.to_hash,
                organization_code: organization_code
              }
            end
          end
        end
      end
    end
  end
end