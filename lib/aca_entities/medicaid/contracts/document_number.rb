# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Document number contract
      class DocumentNumberContract < Dry::Validation::Contract
        params do
          required(:identification_id).filled(:string)
          optional(:identification_category_text).maybe(:string)
          optional(:identification_jurisdication).maybe(:string)
        end
      end
    end
  end
end