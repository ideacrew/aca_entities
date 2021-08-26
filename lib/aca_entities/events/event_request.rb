# frozen_string_literal: true

module AcaEntities
  module Events
    class EventRequest < Dry::Struct

      attribute :requested_at,               Types::DateTime.optional.meta(omittable: false)
      attribute :body,                       Types::String.optional.meta(omittable: false)
    end
  end
end