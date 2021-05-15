# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class InsuranceApplication
            include HappyMapper
            register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

            tag 'InsuranceApplication'
            namespace 'hix-ee'

            has_one :application_creation, ApplicationCreation
            has_one :application_submission, ApplicationSubmission
            has_many :application_identifications, ApplicationIdentification

            has_many :insurance_applicants, InsuranceApplicant

            element :requesting_financial_assistance, Boolean, tag: 'InsuranceApplicationRequestingFinancialAssistanceIndicator', namespace: "hix-ee"
            element :requesting_medicaid, Boolean, tag: "InsuranceApplicationRequestingMedicaidIndicator", namespace: "hix-ee"

            has_one :ssf_primary_contact, SsfPrimaryContact

            element :tax_return_access, Boolean, tag: "InsuranceApplicationTaxReturnAccessIndicator", namespace: "hix-ee"

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.application_creation = ApplicationCreation.domain_to_mapper(insurance_application)
              mapper.application_submission = ApplicationSubmission.domain_to_mapper(insurance_application)
              mapper.application_identifications = [
                ApplicationIdentification.domain_to_mapper(insurance_application.application_metadata.application_id)
                
              ]
              mapper.insurance_applicants = [
                InsuranceApplicant.domain_to_mapper(insurance_application)
              ]
              mapper.requesting_financial_assistance = insurance_application.application_metadata.financial_assistance_indicator
              mapper.requesting_medicaid = insurance_application.application_metadata.medicaid_determination_indicator
              mapper.tax_return_access = insurance_application.attestation.tax_return_access_indicator
              mapper.ssf_primary_contact = SsfPrimaryContact.domain_to_mapper(insurance_application)
              mapper.requesting_financial_assistance = insurance_application.application_metadata.financial_assistance_indicator
              mapper
            end
          end
        end
      end
    end
  end
end