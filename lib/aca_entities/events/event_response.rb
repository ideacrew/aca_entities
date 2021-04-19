# frozen_string_literal: true

module AcaEntities
  module Events
    class EventResponse < Dry::Struct

      attribute :received_at,               Types::Date.optional.meta(omittable: false)
      attribute :body,                      Types::String.optional.meta(omittable: false)
    end
  end
end