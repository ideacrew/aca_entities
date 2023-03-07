# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      # entity for PayNowTransferPayload
      class PayNowTransferPayload < Dry::Struct

        attribute :coverage_kind, AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType.meta(omittable: false)
      end
    end
  end
end