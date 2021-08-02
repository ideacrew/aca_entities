# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Organization identification information contract
      class OrganizationIdentificationContract < Dry::Validation::Contract
        params do
          required(:identification_id).filled(:string)
          optional(:identification_category_text).maybe(:string)
          optional(:identification_jurisdiction).maybe(:string)
        end
      end
    end
  end
end