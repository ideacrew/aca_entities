# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class SsfAttestation
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'SSFAttestation'
            namespace 'hix-ee'

            element :ssf_attestation_non_perjury_indicator, String, tag: 'SSFAttestationNonPerjuryIndicator', namespace: 'hix-ee'
            element :ssf_attestation_information_changes_indicator, String, tag: 'SSFAttestationInformationChangesIndicator', namespace: 'hix-ee'
            element :ssf_attestation_not_incarcerated_indicator, String, tag: 'SSFAttestationNotIncarceratedIndicator', namespace: 'hix-ee'

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.ssf_attestation_non_perjury_indicator = insurance_application.attestation.attested_non_perjury_indicator
              mapper.ssf_attestation_information_changes_indicator = insurance_application.attestation.attested_if_information_changes_indicator
              mapper.ssf_attestation_not_incarcerated_indicator = insurance_application.attestation.attested_not_incarcerated_indicator
              mapper
            end

          end
        end
      end
    end
  end
end
