# frozen_string_literal: true

require 'dry-struct'

module AcaEntities
  module Events
    class EventRequest

      attribute :requested_at,               Types::Date.optional.meta(omittable: false)
      attribute :body,                       Types::String.optional.meta(omittable: false)
    end
  end
end