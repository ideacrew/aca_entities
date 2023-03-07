# frozen_string_literal: true

module AcaEntities
    module PayNow
      module CareFirst
        # entity for PayNowTransferPayload
        class PayNowTransferPayload < Dry::Struct

        #   attribute :pay_now_transfer_payload, Types::Hash.meta(omittable: false)
          attribute :coverage_kind, AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType.meta(omittable: false)
        end
      end
    end
  end