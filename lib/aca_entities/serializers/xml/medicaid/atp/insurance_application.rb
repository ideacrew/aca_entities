# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class InsuranceApplication
            include HappyMapper

            tag 'InsuranceApplication'
            namespace 'hix-ee'

            has_one :application_creation, ApplicationCreation
            has_one :application_submission, ApplicationSubmission
            has_many :application_identifications, ApplicationIdentification

            has_many :insurance_applicants, InsuranceApplicant

            element :requesting_financial_assistance, Boolean, tag: 'InsuranceApplicationRequestingFinancialAssistanceIndicator', namespace: "hix-ee"
            element :requesting_medicaid, Boolean, tag: "InsuranceApplicationRequestingMedicaidIndicator", namespace: "hix-ee"

            has_one :ssf_primary_contact, SsfPrimaryContact

            has_one :ssf_signer, SsfSigner

            has_one :assister_association, InsuranceApplicationAssisterAssociation

            element :tax_return_access, Boolean, tag: "InsuranceApplicationTaxReturnAccessIndicator", namespace: "hix-ee"

            # A number of years for which a signer allows an exchange to renew coverage and determine eligibility (including reuse of tax data).
            element :coverage_renewal_year_quantity, Integer, tag: 'InsuranceApplicationCoverageRenewalYearQuantity'

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.application_creation = ApplicationCreation.domain_to_mapper(insurance_application)
              mapper.application_submission = ApplicationSubmission.domain_to_mapper(insurance_application)
              mapper.application_identifications = [
                ApplicationIdentification.domain_to_mapper(insurance_application.application_metadata.application_ids)

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

            def to_hash
              {
                application_creation: application_creation&.to_hash,
                application_submission: application_submission&.to_hash,
                application_identifications: application_identifications.map(&:to_hash),
                insurance_applicants: insurance_applicants.map(&:to_hash),
                requesting_financial_assistance: requesting_financial_assistance,
                requesting_medicaid: requesting_medicaid,
                ssf_primary_contact: ssf_primary_contact&.to_hash,
                ssf_signer: ssf_signer&.to_hash,
                assister_association: assister_association&.to_hash,
                tax_return_access: tax_return_access,
                coverage_renewal_year_quantity: coverage_renewal_year_quantity
              }
            end
          end
        end
      end
    end
  end
end