# frozen_string_literal: true

require 'dry-struct'

module AcaEntities
  module Events
    class EventResponse

      attribute :received_at,               Types::Date.optional.meta(omittable: false)
      attribute :body,                      Types::String.optional.meta(omittable: false)
    end
  end
end