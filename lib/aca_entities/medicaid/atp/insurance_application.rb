# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplication
      class InsuranceApplication < Dry::Struct

        attribute :application_metadata, ApplicationMetadata.meta(omittable: false)
        attribute :attestation, Attestation.meta(omittable: false)
        #attribute :applicants, Types::Array.of(InsuranceApplicant).meta(omittable: false) #InsuranceApplicant not defined yet
      end
    end
  end
end
