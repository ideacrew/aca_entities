# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Contracts
        # Contract for PayNowTransferPayload
        class PayNowTransferPayloadContract < Dry::Validation::Contract

          params do
            required(:coverage_kind).filled(AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType)
            required(:members).filled(Contracts::MemberContract.params)
          end
        end
      end
    end
  end
end