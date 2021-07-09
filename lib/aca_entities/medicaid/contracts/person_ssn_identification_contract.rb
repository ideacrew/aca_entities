# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # PersonSsnIdentification contract
      class PersonSsnIdentificationContract < Dry::Validation::Contract
        params do
          required(:identification_id).filled(:string)
        end
      end
    end
  end
end