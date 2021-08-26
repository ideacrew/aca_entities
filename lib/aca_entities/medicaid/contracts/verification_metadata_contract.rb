# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # VerificationMetadata contract
      class VerificationMetadataContract < Dry::Validation::Contract
        params do
          required(:verification_date).filled(:hash)
          required(:verification_requesting_system).filled(:hash)
          optional(:address_verification_code).maybe(:string)
          optional(:dhs_g845_verification_code).maybe(:string)
          optional(:dhs_save_verification_code).maybe(:string)
          optional(:ffe_verification_code).maybe(:string)
          optional(:verification_authority_name).maybe(:string)
          optional(:verification_authority_alpha_code).maybe(:string)
          optional(:id).maybe(:string)
          optional(:verification_indicator).maybe(:bool)
          optional(:verification_inconsistency_indicator).maybe(:bool)
          optional(:verification_description_text).maybe(:string)
          optional(:verification_inconsistency_text).maybe(:string)
          optional(:verification_category_codes).maybe(:array)
          optional(:response_code).maybe(:string)
          optional(:verification_status).maybe(:hash)
        end
      end
    end
  end
end