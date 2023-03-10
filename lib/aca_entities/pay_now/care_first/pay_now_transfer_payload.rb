# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      # entity for PayNowTransferPayload
      class PayNowTransferPayload < Dry::Struct

        attribute :coverage_kind, AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType.meta(omittable: false)
        attribute :members, Types::Array.of(AcaEntities::PayNow::CareFirst::Member).meta(omittable: false)
      end
    end
  end
end