# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Sender.
      class SenderContract < Dry::Validation::Contract

        params do
          required(:id).filled(:string)
          required(:category_code).filled(:string)
          optional(:state_code).maybe(:string)
          optional(:county_name).maybe(:string)
        end

        # TODO: Fix these rules later
        rule(:category_code) do
          # key.failure(text: 'Sender Code is invalid') if key? && value
        end

      end
    end
  end
end
