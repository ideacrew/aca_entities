# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Insurance premium contract
      class InsurancePremiumContract < Dry::Validation::Contract
        params do
          optional(:amount).maybe(:float)
          optional(:aptc_amount).maybe(:float)
          optional(:subscriber_amount).maybe(:float)
        end
      end
    end
  end
end