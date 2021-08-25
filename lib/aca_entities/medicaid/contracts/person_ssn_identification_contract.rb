# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # PersonSsnIdentification contract
      class PersonSsnIdentificationContract < Dry::Validation::Contract
        params do
          optional(:identification_id).maybe(:string)
        end
      end
    end
  end
end