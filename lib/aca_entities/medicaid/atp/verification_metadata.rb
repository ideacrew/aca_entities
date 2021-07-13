# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Verification Metadata
      class VerificationMetadata < Dry::Struct

        attribute :verification_date, VerificationDate.meta(omittable: false)
        attribute :verification_requesting_system, VerificationRequestingSystem.meta(omittable: false)
        attribute :address_verification_code, Types::String.optional.meta(omittable: true)
        attribute :dhs_g845_verification_code, Types::String.optional.meta(omittable: true)
        attribute :dhs_save_verification_code, Types::String.optional.meta(omittable: true)
        attribute :ffe_verification_code, Types::String.optional.meta(omittable: true)
        attribute :verification_authority_name, Types::String.optional.meta(omittable: true)
        attribute :verification_authority_alpha_code, Types::String.optional.meta(omittable: true)
        attribute :verification_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :verification_id, Types::String.optional.meta(omittable: true)
        attribute :verification_description_text, Types::String.optional.meta(omittable: true)
        attribute :verification_inconsistency_text, Types::String.optional.meta(omittable: true)
        attribute :verification_inconsistency_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :verification_category_codes, Types::String.optional.meta(omittable: true)
        attribute :response_code, Types::String.optional.meta(omittable: true)
        attribute :verification_status, Types::Array.of(VerificationStatus).optional.meta(omittable: true)
      end
    end
  end
end