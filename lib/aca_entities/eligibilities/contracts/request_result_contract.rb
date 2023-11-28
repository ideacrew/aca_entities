# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts

      # contract for EligibilityResultContract
      class RequestResultContract < Dry::Validation::Contract
        params do
          optional(:result).maybe(:string)
          optional(:source).maybe(:string)
          optional(:source_transaction_id).maybe(:string)
          optional(:code).maybe(:string)
          optional(:code_description).maybe(:string)
          optional(:raw_payload).maybe(:string)
          optional(:action).maybe(:string)
        end
      end
    end
  end
end
