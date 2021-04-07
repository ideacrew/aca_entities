# frozen_string_literal: true

module AcaEntities
  module Verifications
    class VerificationTypeHistoryElement < Dry::Struct

      attribute :verification_type,                 Types::String.optional.meta(omittable: false)
      attribute :action,                            Types::String.optional.meta(omittable: false)
      attribute :modifier,                          Types::String.optional.meta(omittable: false)
      attribute :update_reason,                     Types::String.optional.meta(omittable: false)

      attribute :event_response_record_id,          AcaEntities::Events::EventResponse.optional.meta(omittable: true)
      attribute :event_request_record_id,           AcaEntities::Events::EventRequest.optional.meta(omittable: true)

    end
  end
end

