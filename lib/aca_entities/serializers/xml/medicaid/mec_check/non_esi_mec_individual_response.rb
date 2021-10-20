# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          # Happymapper implementation for the root object of an Individual response.
          class NonEsiMecIndividualResponse
            include HappyMapper
            register_namespace 'gov', 'http://gov.hhs.cms.hix.dsh.ee.nonesi_mec.ext'

            tag 'NonESIMECIndividualResponse'
            namespace 'gov'

            has_one :person_ssn, String, tag: 'PersonSSN', namespace: 'gov'
            has_one :source_information, SourceInformation
            element :organization_code, String, tag: 'OrganizationCode', namespace: 'gov'

            def to_hash
              {
                person_ssn: person_ssn,
                source_information: source_information.to_hash,
                organization_code: organization_code
              }
            end
          end
        end
      end
    end
  end
end
