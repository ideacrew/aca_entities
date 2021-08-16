# frozen_string_literal: true

module AcaEntities
  module Evidences
    # contract for EligibilityDeterminationContract
    class EligibilityDeterminationContract < Dry::Validation::Contract
      params do
        optional(:result).maybe(:symbol)
        optional(:source).maybe(:string)
        optional(:source_transaction_id).maybe(:string)
        optional(:code).maybe(:string)
        optional(:code_description).maybe(::AcaEntities::Evidences::CodeDescriptionContract.params)
      end
    end
  end
end
