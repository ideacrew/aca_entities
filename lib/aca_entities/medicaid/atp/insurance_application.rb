# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplication
      class InsuranceApplication < Dry::Struct

        attribute :insurance_applicants, Types::Array.of(InsuranceApplicant).meta(omittable: false)
        attribute :requesting_financial_assistance, Types::Bool.meta(omittable: false)
        attribute :requesting_medicaid, Types::Bool.meta(omittable: false)
        attribute :ssf_primary_contact, SsfPrimaryContact.meta(omittable: false)
        attribute :ssf_signer, SsfSigner.meta(omittable: false)
        attribute :tax_return_access, Types::Bool.meta(omittable: false)
        attribute :application_creation, ApplicationCreation.meta(omittable: false)
        attribute :application_submission, ApplicationSubmission.meta(omittable: false)
        attribute :application_identifications, Types::Array.of(ApplicationIdentification).meta(omittable: false)
        attribute :coverage_renewal_year_quantity, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end
