# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for SignatureName.
      class SignatureNameContract < Dry::Validation::Contract

        params do
          optional(:given).maybe(:string)
          optional(:middle).maybe(:string)
          optional(:sur).maybe(:string)
          optional(:suffix).maybe(:string)
          optional(:full).maybe(:string)
        end
      end
    end
  end
end
