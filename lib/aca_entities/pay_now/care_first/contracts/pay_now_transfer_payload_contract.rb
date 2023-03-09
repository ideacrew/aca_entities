# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Contracts
        # Contract for PayNowTransferPayload
        class PayNowTransferPayloadContract < Dry::Validation::Contract

          params do
            required(:coverage_kind).filled(AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType)
            required(:primary).filled(AcaEntities::PayNow::CareFirst::Contracts::PrimaryContract.params)
            required(:members).filled(:array)
          end
        end
      end
    end
  end
end