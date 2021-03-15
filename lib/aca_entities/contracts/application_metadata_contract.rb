# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for ApplicationMetadataContract.
    class ApplicationMetadataContract < Dry::Validation::Contract
      params do
        required(:application_id).filled(:string)
        optional(:original_signature_date).maybe(:date)
        required(:application_signature_date).filled(:date_time)
        required(:creation_date).filled(:date_time)
        optional(:update_date).maybe(:date_time)
        optional(:financial_assistance_indicator).maybe(:bool)
        optional(:medicaid_determination_indicator).maybe(:bool)
        required(:identification_category_text).filled(:string)
      end
    end
  end
end
