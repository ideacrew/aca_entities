# frozen_string_literal: true

module AcaEntities
    module PayNow
      module CareFirst
        module Contracts
          # Contract for PayNowTransferPayload
          class PayNowTransferPayloadContract < Dry::Validation::Contract
  
            params do
            #   required(:pay_now_transfer_payload).filled(:hash)
              required(:coverage_kind).filled(AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType)
            end
          end
        end
      end
    end
  end