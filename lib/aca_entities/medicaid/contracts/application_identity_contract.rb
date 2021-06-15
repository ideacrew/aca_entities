# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ApplicationIdentityContract.
      class ApplicationIdentityContract < Dry::Validation::Contract
        params do
          required(:identification_id).filled(:string)
          optional(:identification_category).filled(:string)
          optional(:jurisdiction_iso_3166_code).filled(:string)
        end
      end
    end
  end
end
