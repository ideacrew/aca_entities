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
            has_many :application_updates, ApplicationUpdate
            has_many :application_identifications, ApplicationIdentification
            has_many :insurance_applicants, InsuranceApplicant
            element :requesting_financial_assistance, Boolean, tag: 'InsuranceApplicationRequestingFinancialAssistanceIndicator', namespace: "hix-ee"
            # A number of years for which a signer allows an exchange to renew coverage and determine eligibility (including reuse of tax data).
            element :coverage_renewal_year_quantity, Integer, tag: 'InsuranceApplicationCoverageRenewalYearQuantity'
            has_one :ssf_signer, SsfSigner
            has_one :assister_association, InsuranceApplicationAssisterAssociation
            element :requesting_medicaid, Boolean, tag: "InsuranceApplicationRequestingMedicaidIndicator", namespace: "hix-ee"
            has_one :ssf_primary_contact, SsfPrimaryContact
            element :tax_return_access, Boolean, tag: "InsuranceApplicationTaxReturnAccessIndicator", namespace: "hix-ee"

            def self.domain_to_mapper(insurance_application)
              mapper = self.new
              mapper.application_creation = ApplicationCreation.domain_to_mapper(insurance_application.application_creation)
              mapper.application_submission = ApplicationSubmission.domain_to_mapper(insurance_application.application_submission)
              if insurance_application.respond_to?(:application_updates)
                mapper.application_updates = insurance_application.application_updates.filter_map { |au| ApplicationUpdate.domain_to_mapper(au) }
              end
              mapper.application_identifications = insurance_application.application_identifications.map do |ai|
                ApplicationIdentification.domain_to_mapper(ai)
              end
              mapper.insurance_applicants = insurance_application.insurance_applicants.map do |insurance_applicant|
                InsuranceApplicant.domain_to_mapper(insurance_applicant)
              end
              mapper.requesting_financial_assistance = insurance_application.requesting_financial_assistance
              mapper.coverage_renewal_year_quantity = insurance_application.coverage_renewal_year_quantity
              mapper.ssf_signer = SsfSigner.domain_to_mapper(insurance_application.ssf_signer)
              mapper.requesting_medicaid = insurance_application.requesting_medicaid if insurance_application.requesting_medicaid
              mapper.ssf_primary_contact = SsfPrimaryContact.domain_to_mapper(insurance_application.ssf_primary_contact)
              mapper.tax_return_access = insurance_application.tax_return_access if insurance_application.tax_return_access
              mapper
            end

            def to_hash(identifier: false) # rubocop:disable Metrics/CyclomaticComplexity
              {
                application_creation: application_creation&.to_hash,
                application_submission: application_submission&.to_hash,
                application_updates: application_updates.map(&:to_hash),
                application_identifications: application_identifications.map(&:to_hash),
                insurance_applicants: if identifier
                                        insurance_applicants.map(&:to_hash).group_by do |h|
                                          h[:id]
                                        end.transform_keys(&:to_s).transform_values(&:first)
                                      else
                                        insurance_applicants.map(&:to_hash)
                                      end,
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