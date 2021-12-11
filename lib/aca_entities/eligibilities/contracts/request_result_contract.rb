# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts

      # contract for EligibilityResultContract
      class RequestResultContract < Dry::Validation::Contract
        params do
          optional(:source).maybe(:string)
          optional(:source_transaction_id).maybe(:string)
          optional(:error_code).maybe(:string)
          optional(:error_code_description).maybe(:string)
          optional(:raw_payload).maybe(:string)
        end
      end
    end
  end
end
