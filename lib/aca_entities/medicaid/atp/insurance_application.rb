# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplication
      class InsuranceApplication < Dry::Struct
        
        # attribute :application_creation, ApplicationCreation.meta(omittable: false)
        # attribute :application_submission, ApplicationSubmission.meta(omittable: false)
        # attribute :application_identifications, Types::Array.of(ApplicationIdentification).meta(omittable: false)
        
        attribute :application_metadata, ApplicationMetadata.meta(omittable: false)
        attribute :insurance_applicants, Types::Array.of(InsuranceApplicant).meta(omittable: false) 
        attribute :requesting_financial_assistance, Types::Bool.meta(omittable: false)
        attribute :requesting_medicaid, Types::Bool.meta(omittable: false)
        attribute :ssf_primary_contact, SsfPrimaryContact.meta(omittable: false)
        attribute :ssf_signer, SsfSigner.optional.meta(omittable: true)
        attribute :tax_return_access_indicator, Types::Bool.meta(omittable: false)
      end
    end
  end
end
