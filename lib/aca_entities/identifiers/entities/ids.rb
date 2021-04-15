# frozen_string_literal: true

module AcaEntities
  module Identifiers

    # @example
    # { key: :bt_temp_id, item: 'Fj5jfbTtDySw8JoVsCmeul0wsoIcJKRPV0HtEFUlNvNg6C3wyGj8R1utPbw' }
    # { key: :mobile_phone, item: '+12025551212' }
    class Ids < Dry::Struct
      attribute :key,       Types::Symbol.meta(omittable: true)
      attribute :item,      Types::String.meta(omittable: true)
      attribute :kind,      Types::String.meta(omittable: true) # TODO: Fix me Identifiers::IdentifierKind.optional.meta(omittable: true)
      attribute :start_on,  Types::Date.meta(omittable: true)
      attribute :end_on,    Types::Date.meta(omittable: true)
    end
  end
end