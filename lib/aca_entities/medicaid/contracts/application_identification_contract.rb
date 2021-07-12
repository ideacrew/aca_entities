# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Application creation information contract
      class ApplicationIdentificationContract < Dry::Validation::Contract
        params do
          optional(:identification_id).maybe(:string)
          optional(:identification_category_text).maybe(:string)
          optional(:identification_jurisdication).maybe(:string)
        end
      end
    end
  end
end