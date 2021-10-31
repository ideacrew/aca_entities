# frozen_string_literal: true

module AcaEntities
  module Groups
    class IrsGroup < Dry::Struct

      attribute :hbx_id,                        Types::String.optional.meta(omittable: false)
      attribute :start_on,                      Types::Date.optional.meta(omittable: false)
      attribute :end_on,                        Types::Date.optional.meta(omittable: true)
      attribute :is_active,                     Types::Bool.optional.meta(omittable: true)
    end
  end
end
